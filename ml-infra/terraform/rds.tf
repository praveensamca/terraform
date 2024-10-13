resource "aws_db_subnet_group" "example" {
  name       = "example-db-subnet-group"
  subnet_ids = [aws_subnet.main.id,aws_subnet.main1.id]
}

resource "aws_db_instance" "sam" {
       allocated_storage                     = 20 
       auto_minor_version_upgrade            = true 
       availability_zone                     = "us-east-1a"
       backup_retention_period               = 7 
       copy_tags_to_snapshot                 = true 
       customer_owned_ip_enabled             = false 
       db_subnet_group_name   = aws_db_subnet_group.example.name
       delete_automated_backups              = true 
       deletion_protection                   = false 
       engine                                = "postgres" 
       engine_version                        = "16.1" 
       identifier                            = "database-2" 
       instance_class                        = "db.t3.micro" 
       password                    = "avoid-plaintext-passwords"
       iops                                  = 0 
       network_type                          = "IPV4" 
       performance_insights_enabled          = false
       port                                  = 5432 
       skip_final_snapshot                   = true
       storage_encrypted                     = false
       publicly_accessible = true
       storage_throughput                    = 0
       storage_type                          = "gp2" 
       username                              = "postgres"
       vpc_security_group_ids                = [
           aws_security_group.allow_tls.id,
        ] 
    }


output "rds_ip" {
    value =  resource.aws_db_instance.sam.address
    }

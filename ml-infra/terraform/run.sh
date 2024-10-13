go run templ.go > sam.py
terraform init
terraform plan -out testing
terraform apply testing

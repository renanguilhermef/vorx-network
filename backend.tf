terraform {
    backend "s3"{
        bucket = "renanguilhermef-vorx-terraform"
        key = "vorx-network.tfstate"
        region = "us-east-1"
    }
}
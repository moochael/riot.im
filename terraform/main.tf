# https://medium.com/@jmarhee/digitalocean-spaces-as-a-terraform-backend-b761ae426086
terraform {
  backend "s3" {
    endpoint = "sfo2.digitaloceanspaces.com"
    region = "us-west-1"
    key = "terraform.tfstate"
    skip_requesting_account_id = true
    skip_credentials_validation = true
    skip_get_ec2_platforms = true
    skip_metadata_api_check = true
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a droplet
resource "digitalocean_droplet" "riot-homeserver" {
  image  = "centos-7-x64"
  name   = "riot.im"
  region = "sfo1"
  size   = "s-1vcpu-1gb"
}

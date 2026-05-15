
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0cca150d127c2216f"
  instance_type = "t3.micro"
  key_name      = "my-key"

  tags = {
    Name = "TerraformCloudEC2"
  }
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
    
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "amazon-ami-linux" {
  region          = "us-east-2"
  ami_name        = "packer-ami-v1.0.1-{{timestamp}}"
  ami_description = "Amazon Linux AMI for the DevOps-Cloud July project"
  instance_type   = "t2.micro"
  source_ami      = "ami-0f34c5ae932e6f0e4" # Amazon Linux 2023
  ssh_username    = "ec2-user"
  #ami_users      = ""
  ami_regions     = ["us-east-2"]
}

build {
  name = "km-packer"
  sources = [
    "source.amazon-ebs.amazon-ami-linux"
  ]

  provisioner "shell" {
    inline = [
      "yum install python3-pip -y",
      "pip install ansible"
    ]
  }

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
  }
}
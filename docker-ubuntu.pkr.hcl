packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "repo" {
  type    = string
}

variable "user"{
  type = string
}

variable "pass"{
  type = string
}

variable "version"{
  type = string
}

source "docker" "ubuntu" {
  image  = "ubuntu:focal"
  commit = true
    changes = [
      "EXPOSE 8080",
      "WORKDIR /home/calculator",
      "ENTRYPOINT ./calculator"
    ]
}

build {
  name    = "go-calculator"
  sources = [
    "source.docker.ubuntu"
  ]
  provisioner "shell"{
    inline = [
      "apt-get update", 
      "apt-get install -y pip",
      "pip install packaging",
      "pip install ansible"
    ]
  }

  provisioner "file" {
    source = "./calculator"
    destination = "/home/"
  }

  provisioner "ansible-local" {
    playbook_file = "./ansible/playbook.yml"
  }

    provisioner "shell"{
    inline = [
      "cd /home/calculator", 
      "go build calculator.go"
    ]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = var.repo
      tags        = [var.version]
  }
    post-processor "docker-push" {
      login = true
      login_username = var.user
      login_password = var.pass
    }
  }
}

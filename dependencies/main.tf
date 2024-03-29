provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"

  tags = {
    Name = "Web-server"
  }

  #it will create DB instace first - depends
  depends_on = [aws_instance.db]
}

resource "aws_instance" "db" {
  ami           = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"

  tags = {
    Name = "DB-sever"
  }
}

data "aws_instance" "dbsearch" {
  filter {
    name = "tag:Name"
    values = [ "DB server" ]
  }
}

output "dbservers" {
  value = data.aws_instance.dbsearch.availability_zone
}


resource "aws_security_group" "sg" {
  name        = "openall"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.sri.id

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "mysg"
  }
}
data "aws_ami" "sri_ami" {

  owners = ["099720109477"]

  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }
}


## (To get ami--->aws ec2 describe-images --image-ids ami-053b0d53c279acc90)
## To create EC2 in through command line ---->aws ec2 run-instances --image-id ami-053b0d53c279acc90 --count 5 --instance-type t2.micro --key-name ssh-key --security-group-ids sg-003e64741b500c9e3 --subnet-id subnet-0458682a233a4536e
## To Terminate instance ---->aws ec2 terminate-instances  --instance-ids i-0146977d4c59a80ee i-0d53520b2baee6896
resource "aws_key_pair" "key-pair" {
  key_name   = "key-gen2"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.sri_ami.id
  instance_type = "t2.micro"
  user_data     = file("awscli.sh")
  key_name      = "key-gen2"
  subnet_id     = data.aws_subnet.web.id
  ##subnet_id = aws_subnet.sri_sub[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web.public_ip
  }
  provisioner "file" {
    source      = "apche2.sh"
    destination = "/home/ubuntu/apache2.sh"
  }

  provisioner "remote-exec" {
    scripts = ["awscli.sh" , "awsconfig.sh" ,"kubectl.sh"]

  }

  tags = {
    Name = "first_instance"
  }
}

output "url" {
  value = aws_instance.web.public_ip
}






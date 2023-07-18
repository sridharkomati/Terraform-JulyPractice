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
  instance_type = "t2.medium"
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
    source = "cluster.yaml"
    destination = "/home/ubuntu/cluster.yaml"
     
  }
  provisioner "file" {
    source = "key.sh"
    destination = "/home/ubuntu/.ssh/id_rsa.pub"
  }
  provisioner "remote-exec" {
    inline = [ 
      "curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl",
      "chmod +x ./kubectl",
      "mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH",
      "curl --silent --location https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz | tar xz -C /tmp",
      "sudo mv /tmp/eksctl /usr/local/bin",
      "eksctl version",
    ]

  }
 
  

  tags = {
    Name = "eksctl_instance"
  }
}

output "url" {
  value = aws_instance.web.public_ip
}






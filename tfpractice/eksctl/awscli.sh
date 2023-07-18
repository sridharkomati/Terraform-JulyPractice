#!/bin/bash
sudo apt update
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo -i
echo "export AWS_ACCESS_KEY_ID="AKIA2DMDAP73T75QCBLO"" >> /etc/environment
echo "export AWS_SECRET_ACCESS_KEY="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"" >> /etc/environment
echo "export AWS_DEFAULT_REGION="us-west-2"" >> /etc/environment
##echo "export AWS_PROFILE="newuser1234"" >> /etc/environment
source ~/.bashrc
exit




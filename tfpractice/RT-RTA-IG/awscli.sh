#!/bash/bin
sudo apt update 
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


export AWS_ACCESS_KEY_ID=AKIA2DMDAP735I74YFK2
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-east-1

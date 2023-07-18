sudo -i
echo "export AWS_ACCESS_KEY_ID="AKIA2DMDAP73T75QCBLO"" >> /etc/environment
echo "export AWS_SECRET_ACCESS_KEY="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"" >> /etc/environment
echo "export AWS_DEFAULT_REGION="us-west-2"" >> /etc/environment
source ~/.bashrc
exit
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
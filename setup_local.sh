
sudo su
yum update -y
yum install golang curl git java-1.8.0 -y
amazon-linux-extras install -y docker
usermod -a -G docker ec2-user
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-x86_64.rpm
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-x86_64.rpm.sha512
sha512sum -c elasticsearch-7.15.2-x86_64.rpm.sha512
rpm --install elasticsearch-7.15.2-x86_64.rpm
systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch
service docker start
git clone https://github.com/ronnathaniel/jaeger-instance.git
cd jaeger-instance
./start-jaeger.sh

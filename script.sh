apt install openjdk-17-jdk
useradd dataverse
apt install wget
Y
wget https://nexus.payara.fish/repository/payara-community/fish/payara/distributions/payara/6.2023.8/payara-6.2023.8.zip
apt install unzip
unzip payara-6.2023.8.zip 
mv payara6 /usr/local
chown -R root:root /usr/local/payara6
chown dataverse /usr/local/payara6/glassfish/lib
chown -R dataverse:dataverse /usr/local/payara6/glassfish/domains/domain1
apt install nano
wget https://guides.dataverse.org/en/latest/_downloads/c08a166c96044c52a1a470cc2ff60444/payara.service
cp payara.service /etc/systemd/system
systemctl daemon-reload
apt install postgresql-14
Y
região 2
area 135

systemctl restart postgresql-13
useradd solr
mkdir /usr/local/solr
chown solr:solr /usr/local/solr
sudo su solr
cd /usr/local/solr
wget https://archive.apache.org/dist/solr/solr/9.3.0/solr-9.3.0.tgz
tar xvzf solr-9.3.0.tgz
cd solr-9.3.0
cp -r server/solr/configsets/_default server/solr/collection1

cp /tmp/dvinstall/schema*.xml /usr/local/solr/solr-9.3.0/server/solr/collection1/conf
cp /tmp/dvinstall/solrconfig.xml /usr/local/solr/solr-9.3.0/server/solr/collection1/conf

echo "solr soft nproc 65000
solr hard nproc 65000
solr soft nofile 65000
solr hard nofile 65000" | sudo tee -a /etc/security/limits.conf

apt install lsof
echo "name=collection1" > /usr/local/solr/solr-9.3.0/server/solr/collection1/core.properties
exit
wget https://guides.dataverse.org/en/latest/_downloads/0736976a136678bbc024ce423b223d3a/solr.service

systemctl daemon-reload
systemctl start solr.service
systemctl enable solr.service

sudo apt-get update
sudo apt-get install -yq ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -yq docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service



sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1

sudo mkdir /disk
sudo mkdir /mnt/shared

sudo mount /dev/sdc1 /disk

uuid=$(sudo blkid /dev/sdc1 -o value | head -n 1)
sudo bash -c 'echo "UUID=$0 /disk   xfs   defaults,nofail   1   2" >> /etc/fstab' $uuid
sudo chgrp -R docker /disk

password=$1
echo $password > disk.key

#if [ ! -d "/etc/smbcredentials" ]; then
#sudo mkdir /etc/smbcredentials
#fi
#if [ ! -f "/etc/smbcredentials/corraibidatastorage.cred" ]; then
#    sudo bash -c 'echo "username=corraibidatastorage" >> /etc/smbcredentials/corraibidatastorage.cred'
#    sudo bash -c 'echo "password=$0" >> /etc/smbcredentials/corraibidatastorage.cred' $password
#fi
#sudo chmod 600 /etc/smbcredentials/corraibidatastorage.cred
#sudo bash -c 'echo "//corraibidatastorage.file.core.windows.net/corraibifilestorage /mnt/shared cifs nofail,vers=3.0,credentials=/etc/smbcredentials/corraibidatastorage.cred,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
#sudo mount -t cifs //corraibidatastorage.file.core.windows.net/corraibifilestorage /mnt/shared -o vers=3.0,credentials=/etc/smbcredentials/corraibidatastorage.cred,dir_mode=0777,file_mode=0777,serverino


#!/bin/bash

if [$# -lt 3]; then
    echo $0 ''
    echo Argument error!
    echo Usage:
    echo   $0 username user_pubkey
    exit
fi


# add ssh settings
username = $1
useradd $username
mkdir /home/$username
mkdir /home/$username/.ssh
touch /home/$username/.ssh/authorized_keys
cat $2 >> /home/$username/.ssh/authorized_keys
chmod 700 /home/$username/.ssh
chmod 400 /home/$username/.ssh/autorized_keys
chown -R $username:$username /home/$username

service ssh restart

# add to sudoers
echo '$username ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

su $username
# update
sudo apt-get update
sudo apt-get upgrade

# install python-pip
sudo apt-get install python-pip

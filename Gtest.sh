#! /bin/bash
printf "Installing RDP Please Wait 4 or 5 Min It's Made by Hassan Ahmed 2021" >&2
{
sudo useradd -m HosRDP
sudo adduser HosRDP sudo
echo 'HosRDP:123456' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes mate-desktop-environment
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/mate-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 
sudo adduser HosRDP chrome-remote-desktop
sudo apt install ffmpeg -y
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt install obs-studio -y
sudo apt install vlc -y
sudo apt install firefox -y
sudo apt install xarchiver -y
sudo apt install openshot -y
} &> /dev/null &&
printf "\nSetup Complete " >&2 ||
printf "\nError Occured " >&2
printf '\nCheck https://remotedesktop.google.com/headless  Copy Command Of Debian Linux And Paste Down\n'
read -p "Paste Here:- " CRP
su - HosRDP -c """$CRP"""
printf 'Check Now The RDP in https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\nUpgrade Completed " >&2
else
    printf "\n\nError Occured " >&2
fi

#! /bin/bash

# Make Instance Ready for Remote Desktop or RDP

b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'

clear

# Branding

printf """$c$b
 
██╗  ██╗ █████╗ ███████╗███████╗ █████╗ ███╗   ██╗     █████╗ ██╗  ██╗███╗   ███╗███████╗██████╗ 
██║  ██║██╔══██╗██╔════╝██╔════╝██╔══██╗████╗  ██║    ██╔══██╗██║  ██║████╗ ████║██╔════╝██╔══██╗
███████║███████║███████╗███████╗███████║██╔██╗ ██║    ███████║███████║██╔████╔██║█████╗  ██║  ██║
██╔══██║██╔══██║╚════██║╚════██║██╔══██║██║╚██╗██║    ██╔══██║██╔══██║██║╚██╔╝██║██╔══╝  ██║  ██║
██║  ██║██║  ██║███████║███████║██║  ██║██║ ╚████║    ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗██████╔╝
╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═════╝ 
                                                                                                 
    $r  By Hassan Ahmed © 2021 $c 
          
$endc$enda""";



# Used Two if else type statements, one is simple second is complex. So, don't get confused or fear by seeing complex if else statement '^^.

# Creation of user
printf "\n\nCreating user " >&2
if sudo useradd -m HosRdp &> /dev/null
then
  printf "\ruser created $endc$enda\n" >&2
  printf "\rUsername:- HosRdp $endc$enda\n" >&2
  printf "\rPassword:- 123456 $endc$enda\n" >&2
else
  printf "\r$r$b Error Occured $endc$enda\n" >&2
  exit
fi

# Add user to sudo group
sudo adduser HosRdp sudo

# Set password of user to 'root'
echo 'HosRdp:123456' | sudo chpasswd

# Change default shell from sh to bash
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Initialisation of Installer
printf "\n\n$c$b    Loading Installer $endc$enda" >&2
if sudo apt-get update &> /dev/null
then
    printf "\r$g$b    Installer update Loaded $endc$enda\n" >&2
else
    printf "\r$r$b    Error Occured $endc$enda\n" >&2
    exit
fi

# Installing Chrome Remote Desktop
printf "\n$g$b    Installing Chrome Remote Desktop $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Chrome Remote Desktop Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }



# Install Desktop Environment (XFCE4)
printf "$g$b    Installing Desktop Environment $endc$enda" >&2
{
    sudo DEBIAN_FRONTEND=noninteractive \
        apt install --assume-yes xfce4 desktop-base
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
} &> /dev/null &&
printf "\r$c$b    Desktop Environment Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }


# Install Google Chrome
printf "$g$b    Installing Google Chrome $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
    sudo apt-get install -y xfce4-terminal
} &> /dev/null &&
printf "\r$c$b    Google Chrome Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2


# Install OBS-Studio (Livestream)
printf "$g$b    Installing Obs-studio $endc$enda" >&2
{
    sudo apt install ffmpeg -y
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo apt install obs-studio -y
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    OBS-Studio Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install VLC Media Player 
printf "$g$b    Installing VLC Media Player $endc$enda" >&2
{
    sudo apt install vlc -y
} &> /dev/null &&
printf "\r$c$b    VLC Media Player Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install OpenShot & Kdenlive
printf "$g$b    Installing OpenShot & Kdenlive $endc$enda" >&2
{
    sudo apt install openshot -y
    sudo apt install kdenlive -y
} &> /dev/null &&
printf "\r$c$b    OpenShot & Kdenlive Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2




printf "\n$g$b    Installation RDP Completed Successfully $endc$enda\n\n" >&2



# Adding user to CRP group
sudo adduser HosRdp chrome-remote-desktop

# Finishing Work
printf '\nVisit http://remotedesktop.google.com/headless and Copy the command after authentication\n'
read -p "Paste Command Here:- " CRP
su - HosRdp -c """$CRP"""

printf "\n$c$b if mistakenly wrote wrong command or pin, Rerun the current box or run command 'su - HosRdp -c '<CRP Command Here>' $endc$enda\n" >&2
printf "\n$c$b https://remotedesktop.google.com/access to access your RDP, do not close browser tab to keep colab running ' $endc$enda\n" >&2
printf "\n$g$b Finished Succesfully ,Enjoy it $endc$enda"

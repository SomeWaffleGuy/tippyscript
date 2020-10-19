#/bin/bash
#TippyScript: Fedora setup script
#CURRENT VERSION: 33
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)This script will configure a fresh install of Fedora Workstation to be what I consider a useable desktop. This includes$(tput sgr 0)$(tput setaf 1)$(tput bold) NON-FREE SOFTWARE AND DRIVERS$(tput sgr 0)$(tput setaf 2)$(tput bold) and suggests software which may be subject to restrictions under local law. $(tput sgr 0)"
echo -n "$(tput setaf 2)$(tput bold)Continue? 
(y/N)$(tput sgr 0) "
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "$(tput setaf 2)$(tput bold)Checking for system updates...$(tput sgr 0)"
  sudo rpm-ostree upgrade
  echo "$(tput setaf 2)$(tput bold)Downloading and installing RPM Fusion$(tput sgr 0)"
  wget https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo rpm-ostree install *.rpm
  rm *.rpm
  echo "$(tput setaf 2)$(tput bold)RESTART AND RUN silverblue_b.sh$(tput sgr 0)"
fi
exit 0

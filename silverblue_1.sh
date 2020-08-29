#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)Silverblue is designed to be a very basic core system with Flatpak acting as the main install method for applications$(tput sgr 0)"
echo "$(tput setaf 2)$(tput bold)To that end; the setup will be far more basic, focusing on things outisde Flatpak via rpm-ostree$(tput sgr 0)"
echo "$(tput setaf 2)$(tput bold)You will need to restart several times and run the scripts in numeric order$(tput sgr 0)"
echo "$(tput setaf 2)$(tput bold)Also be sure to have enabled the fedora-cisco-openh264 repo$(tput sgr 0)"
echo "$(tput setaf 2)$(tput bold)This is located at /etc/yum.repos.d/fedora-cisco-openh264.repo$(tput sgr 0)"
sleep 3
echo "$(tput setaf 2)$(tput bold)Adding RPMFusion$(tput sgr 0)"
sleep 3
	rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo -n "$(tput setaf 2)$(tput bold)RESTARTING, RUN SCRIPT 2 AFTER BOOT IF YOU WANT TAINTED REPOS$(tput sgr 0)"
sleep 3
	reboot
exit 0

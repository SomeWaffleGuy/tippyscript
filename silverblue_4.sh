#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
rpm-ostree install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
echo -n "$(tput setaf 2)$(tput bold)RESTARTING, ALL RPM-OSTREE MODIFICTIONS DONE$(tput sgr 0)"
sleep 3
	reboot
exit 0

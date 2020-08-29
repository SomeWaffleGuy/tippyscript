#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo -n "$(tput setaf 2)$(tput bold)Enable Tainted repos? (Y/N)$(tput sgr 0) "
read answer
	if echo "$answer" | grep -iq "^y" ;then
	rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
fi
echo -n "$(tput setaf 2)$(tput bold)RESTARTING, RUN SCRIPT 3 AFTER BOOT$(tput sgr 0)"
sleep 3
	reboot
exit 0

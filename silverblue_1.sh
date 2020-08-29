#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
exit 0

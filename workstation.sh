#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
dnf remove gnome-maps gnome-boxes totem gnome-photos libreoffice*
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf groupupdate core
dnf upgrade
dnf install steam wine-dxvk unrar zip curl cabextract xorg-x11-font-utils fontconfig mpv youtube-dl intel-media-driver
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0

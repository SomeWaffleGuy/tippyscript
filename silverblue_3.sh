#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
rpm-ostree install steam wine-dxvk unrar cabextract fontconfig intel-media-driver
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0

#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
sudo su -c 'dnf remove gnome-maps gnome-boxes totem gnome-photos libreoffice*'
sudo su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm'
sudo su -c 'dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
sudo su -c 'dnf groupupdate core'
sudo su -c 'dnf upgrade'
sudo su -c 'dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin'
sudo su -c 'dnf groupupdate sound-and-video'
sudo su -c 'dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted'
sudo su -c 'dnf install steam wine-dxvk unrar zip curl cabextract xorg-x11-font-utils fontconfig mpv youtube-dl mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libdvdcss libva-utils ffmpegthumbnailer neofetch nextcloud-client'
sudo su -c 'dnf install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm'
##Use for Intel GPU
#sudo su -c 'dnf install intel-media-driver libvdpau-va-gl'
##Use for Nvidia GPU
#sudo su -c 'dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver'
#sudo su -c "grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0

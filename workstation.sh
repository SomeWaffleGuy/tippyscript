#/bin/bash
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
dnf -y remove gnome-maps gnome-boxes totem gnome-photos libreoffice*
dnf -y install "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
dnf -y install "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
dnf -y groupupdate core
dnf -y upgrade
dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf -y groupupdate sound-and-video
dnf -y install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
dnf -y install steam wine-dxvk unrar zip curl cabextract xorg-x11-font-utils fontconfig mpv youtube-dl mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libdvdcss libva-utils ffmpegthumbnailer neofetch nextcloud-client
dnf -y install "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm"
##Use for Intel GPU
#dnf -y install intel-media-driver libvdpau-va-gl
##Use for Nvidia GPU
#dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver
#grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0

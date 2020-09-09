#/bin/bash
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)Uninstalling useless GNOME parts$(tput sgr 0)"
dnf -y remove gnome-maps gnome-boxes totem gnome-photos libreoffice*
echo "$(tput setaf 2)$(tput bold)Making sure wget is installed$(tput sgr 0)"
dnf -y install wget
echo "$(tput setaf 2)$(tput bold)Downloading and installing RPMFusion and MS Fonts$(tput sgr 0)"
wget https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
wget https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
wget https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
dnf -y install *.rpm
rm *.rpm
dnf -y upgrade
echo "$(tput setaf 2)$(tput bold)Setting up basic multimedia functionality$(tput sgr 0)"
dnf -y groupupdate core
dnf -y upgrade
dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf -y groupupdate sound-and-video
echo "$(tput setaf 2)$(tput bold)Adding RPMFusion tainted repos$(tput sgr 0)"
dnf -y install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
dnf -y install steam wine-dxvk unrar zip curl cabextract xorg-x11-font-utils fontconfig mpv youtube-dl mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libdvdcss libva-utils ffmpegthumbnailer neofetch nextcloud-client
echo -n "$(tput setaf 2)$(tput bold)Install Intel Media Driver? (VAAPI support for Intel GPUs)$(tput sgr 0) "
read answer
if echo "$answer" | grep -iq "^y" ;then
  dnf -y install intel-media-driver libvdpau-va-gl
fi
echo -n "$(tput setaf 2)$(tput bold)Install NVIDIA drivers?$(tput sgr 0) "
read answer
if echo "$answer" | grep -iq "^y" ;then
  dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver
  grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
fi
echo "$(tput setaf 2)$(tput bold)Enabling Flathub$(tput sgr 0)"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0

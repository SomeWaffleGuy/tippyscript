#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)Uninstalling useless GNOME parts$(tput sgr 0)"
sleep 3
	dnf remove gnome-maps gnome-boxes totem gnome-photos libreoffice*
echo "$(tput setaf 2)$(tput bold)Adding RPMFusion and upgrading$(tput sgr 0)"
sleep 3
	dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	dnf groupupdate core
	dnf upgrade
echo -n "$(tput setaf 2)$(tput bold)Select Install options
1: Typical Install
2: Custom Install
$(tput sgr 0)"
read answer
if echo "$answer" | grep -iq "^2" ;then
	echo -n "$(tput setaf 2)$(tput bold)Install Non-Free media codecs? (Y/N)$(tput sgr 0) "
	read answer
		if echo "$answer" | grep -iq "^y" ;then
		dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
		dnf groupupdate sound-and-video
		dnf install mozilla-openh264 compat-ffmpeg28 ffmpeg-libs
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install Tainted repos and enable DVD playback? (Local laws apply) (Y/N)$(tput sgr 0) "
	read answer
		if echo "$answer" | grep -iq "^y" ;then
		dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
		dnf install libdvdcss
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install mpv? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		dnf install mpv youtube-dl
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install MS Fonts? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		dnf install curl cabextract xorg-x11-font-utils fontconfig
		rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install unrar and zip? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		dnf install unrar zip
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install proprietary Nvidia drivers? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils 
		grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
	fi
	echo -n "$(tput setaf 2)$(tput bold)Which browser?
1: Firefox
2: Chromium (VAAPI Enabled)
$(tput sgr 0)"
	read answer
	if echo "$answer" | grep -iq "^2" ;then
		dnf install chromium-freeword
		dnf remove firefox
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install Steam and DXVK support? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		dnf install steam wine-dxvk
	fi
	echo -n "$(tput setaf 2)$(tput bold)Enable Flathub? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	fi
fi
elif echo "$answer" | grep -iq "^1" ;then
	#Install all of the usual things
	dnf install steam wine-dxvk unrar zip curl cabextract xorg-x11-font-utils fontconfig mpv youtube-dl
	rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	#Ask for GPU to set up KMS
	echo -n "$(tput setaf 2)$(tput bold)Which GPU do you have?
1: Intel/AMD/ATI/Nvidia (Nouveau)
2: Nvidia (Proprietary)
$(tput sgr 0)"
	read answer
	if echo "$answer" | grep -iq "^2" ;then
	dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils
	grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
	elif echo"$answer" | grep -iq "^1" ;then
fi
echo -n "$(tput setaf 2)$(tput bold)RESTARTING$(tput sgr 0)"
sleep 3
	reboot
exit 0

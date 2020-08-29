#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo -n "$(tput setaf 2)$(tput bold)Select Install options
1: Typical Install
2: Custom Install
$(tput sgr 0)"
read answer
if echo "$answer" | grep -iq "^2" ;then
	echo -n "$(tput setaf 2)$(tput bold)Install Non-Free media codecs? (Y/N)$(tput sgr 0) "
	read answer
		if echo "$answer" | grep -iq "^y" ;then
		rpm-ostree install mozilla-openh264 compat-ffmpeg28 ffmpeg-libs
	fi
	echo -n "$(tput setaf 2)$(tput bold)Enable DVD playback? (Requires Tainted repos) (Y/N)$(tput sgr 0) "
	read answer
		if echo "$answer" | grep -iq "^y" ;then
		rpm-ostree install libdvdcss
	fi
	echo -n "$(tput setaf 2)$(tput bold)Set up for MS Fonts? (Will need to run script 4 after reboot) (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		rpm-ostree install curl cabextract xorg-x11-font-utils fontconfig
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install unrar and zip? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		rpm-ostree install unrar zip
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install proprietary Nvidia drivers? (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils 
		grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
	fi
	echo -n "$(tput setaf 2)$(tput bold)Which browser?
1: Firefox
2: Chromium (VAAPI Enabled)
$(tput sgr 0)"
	read answer
	if echo "$answer" | grep -iq "^2" ;then
		rpm-ostree install chromium-freeword
		rpm-ostree remove firefox
	fi
	echo -n "$(tput setaf 2)$(tput bold)Install Steam and DXVK support? (If you want Steam, the RPM is recommended) (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		rpm-ostree install steam wine-dxvk
	fi
	echo -n "$(tput setaf 2)$(tput bold)Enable Flathub? (HIGHLY recommended for Silverblue) (Y/N)$(tput sgr 0) "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	fi
fi
elif echo "$answer" | grep -iq "^1" ;then
	#Install all of the usual things
	rpm-ostree install steam wine-dxvk unrar zip curl cabextract xorg-x11-font-utils fontconfig
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	#Ask for GPU
	echo -n "$(tput setaf 2)$(tput bold)Which GPU do you have?
1: Intel/AMD/ATI/Nvidia (Nouveau)
2: Nvidia (Proprietary)
$(tput sgr 0)"
	read answer
	if echo "$answer" | grep -iq "^2" ;then
	rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils
	grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
	elif echo"$answer" | grep -iq "^1" ;then
fi
echo -n "$(tput setaf 2)$(tput bold)RESTARTING, RUN SCRIPT 4 AFTER BOOT IF MS FONTS OR TYPICAL SELECTED$(tput sgr 0)"
sleep 3
	reboot
exit 0

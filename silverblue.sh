#/bin/bash
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)This script will configure a fresh install of Fedora Workstation to be what I consider a useable desktop. This includes$(tput sgr 0)$(tput setaf 1)$(tput bold) NON-FREE SOFTWARE AND DRIVERS$(tput sgr 0)$(tput setaf 2)$(tput bold) and suggests software which may be subject to restrictions under local law. $(tput sgr 0)"
echo -n "$(tput setaf 2)$(tput bold)Continue? 
(y/N)$(tput sgr 0) "
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "$(tput setaf 2)$(tput bold)Checking for system updates...$(tput sgr 0)"
  sudo rpm-ostree upgrade
  echo "$(tput setaf 2)$(tput bold)Downloading and installing RPM Fusion$(tput sgr 0)"
  wget https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo rpm-ostree install *.rpm
  rm *.rpm
  echo "$(tput setaf 2)$(tput bold)Installing typical applications...$(tput sgr 0)"
  sudo rpm-ostree install gnome-tweaks mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libva-utils ffmpegthumbnailer neofetch vulkan gdouros-symbola-fonts google-noto-emoji-fonts google-noto-emoji-color-fonts google-android-emoji-fonts
  echo -n "$(tput setaf 2)$(tput bold)Select your GPU
1: Intel
2: AMD
3: NVIDIA
4: Other/FOSS Drivers
$(tput sgr 0)"
  read answer
  if echo "$answer" | grep -iq "^1" ;then
    sudo rpm-ostree install intel-media-driver mesa-vulkan-drivers libvdpau-va-gl
  elif echo "$answer" | grep -iq "^2" ;then
    sudo rpm-ostree install xorg-x11-drv-amdgpu mesa-vulkan-drivers
    echo "$(tput setaf 2)$(tput bold)Additional configuration may be required to use the AMDGPU driver. I do not have a modern AMD GPU for testing.$(tput sgr 0) "
  elif echo "$answer" | grep -iq "^3" ;then
    sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver
  fi
  echo -n "$(tput setaf 2)$(tput bold)Enable S32LE in PulseAudio? (Generally fine for modern systems, skip if unsure) 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo sed -i "s/; default-sample-format = s16le/default-sample-format = s32le/g" /etc/pulse/daemon.conf
    sudo sed -i "s/; resample-method = speex-float-1/resample-method = speex-float-10/g" /etc/pulse/daemon.conf
    sudo sed -i "s/; avoid-resampling = false/avoid-resampling = true/g" /etc/pulse/daemon.conf
  fi
  echo "$(tput setaf 2)$(tput bold)Enabling Flathub$(tput sgr 0)"
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  echo "$(tput setaf 2)$(tput bold)Making GNOME more useable...$(tput sgr 0)"
  gnome-extensions disable background-logo@fedorahosted.org
  gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
  gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
  gsettings set org.gnome.desktop.interface clock-show-date 'true'
  gsettings set org.gnome.desktop.interface clock-show-weekday 'true'
  gsettings set org.gnome.desktop.interface enable-hot-corners 'false'
  gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
  gsettings set org.gnome.nautilus.preferences show-create-link 'true'
  gsettings set org.gnome.nautilus.preferences thumbnail-limit '4096'
  gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
  gsettings set org.gnome.gedit.preferences.editor bracket-matching 'false'
  gsettings set org.gnome.gedit.preferences.editor highlight-current-line 'false'
  echo -n "$(tput setaf 2)$(tput bold)Use dark theme? 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
  fi
    sudo mkdir /etc/dconf/db/gdm.d/
# Setting 12h time has mixed results in GDM. I cannot find out why or how to fix it. GDM is the worst documented software on the Internet.
  echo -n "$(tput setaf 2)$(tput bold)Use 12 hour time? 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    echo "[org/gnome/desktop/interface]
clock-format='12h'" > ~/01-clock-format
sudo mv ~/01-clock-format /etc/dconf/db/gdm.d/
  gsettings set org.gnome.desktop.interface clock-format '12h'
  fi
  echo -n "$(tput setaf 2)$(tput bold)Enable Tap-to-Click for Touchpads? 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo su -c 'echo "[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true" > /etc/dconf/db/gdm.d/06-tap-to-click'
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'
  fi
  sudo dconf update
  echo "$(tput setaf 2)$(tput bold)RESTART REQUIRED TO COMPLETE SETUP$(tput sgr 0)"
fi
exit 0

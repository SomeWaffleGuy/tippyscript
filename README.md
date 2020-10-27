# TippyScript
Messy Fedora setup scripts, massively WIP

Should (mostly) work and provide a basic useable system

### Instructions for Fedora Workstation

```
wget https://raw.githubusercontent.com/SomeWaffleGuy/tippyscript/master/workstation.sh
chmod +x workstation.sh
./workstation.sh
```

### Instructions for Fedora Silverblue

```
wget https://raw.githubusercontent.com/SomeWaffleGuy/tippyscript/master/silverblue_a.sh
wget https://raw.githubusercontent.com/SomeWaffleGuy/tippyscript/master/silverblue_b.sh
chmod +x silverblue_a.sh
chmod +x silverblue_b.sh
./silverblue_a.sh
FOLLOWING A RESTART
./silverblue_b.sh
```

Silverblue requires a restart for overlay packages to apply, which includes RPM Fusion. The script needs to be run in parts, although there is an experimental way to apply changes without a reboot, it is unsupported for now, and thus not used.

# Configuration Tips
### Celluloid

Celluloid does NOT default to hardware decoding. In order to activate it for Intel/AMD, add the following to 'Extra MPV options'

```
--hwdec=vaapi
```

Or for NVIDIA, add;

```
--hwdec=vdpau
```

Any standard MPV options can be added this way, or with a config file.

### Firefox

Firefox supports hardware acceleration on ALL GPUs, and hardware video decoding on Intel/AMD GPUs. Please see;

https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration

For more information.

NVIDIA users may still wish to enable WebRender right now despite the lack of video decoding. DO NOT enable MOZ_X11_EGL, despite the transparent window bug being addressed, peformance is far from ideal.

### Extensions

By default, this script enables the 'Kstatusnotifieritem/appindicator support' extension and disables the 'Background logo' extension. Any and all extensions can be enabled/disabled via the installed GNOME Tweaks application. Many extensions are available in the Fedora repositories, with many more at;

https://extensions.gnome.org/

### High Refresh Rate with NVIDIA (More than 60 Hz)

High refresh rate monitors can be used on NVIDIA cards, but require some configuration, especially in mixed refresh rate setups.

For starters, one should set Mutter's default FPS to their target refresh rate by adding the following to /etc/environment;
```
CLUTTER_DEFAULT_FPS=[RATE]
```

Where [RATE] is the target refresh rate.

In mixed refresh rate setups, one shoud also add;
```
__GL_SYNC_DISPLAY_DEVICE=[DEVICE]
```

Where [DEVICE] is the output of your higher refresh rate monitor (DP-4 or HDMI-2 for example).

GSYNC is NOT supported in multi-monitor configurations for the time being, however, as NVIDIA support for Wayland improves and becomes usable, this may change and (hopefully) make this section obsolete.

### Flatpak Applications

When installing Flatpak applications, often times there will be a 'Fedora' and a 'Flathub' version. The 'Flathub' versions are more often up-to-date and, as such, I would recommend prefering them.

### Themes

Theming is a waste of time and Adwaita/Adwaita-Dark look fine.

But if you insist, Fedora does have various themes in its repos, and many more out there through build systems.

Be sure to install the Flatpak version of whatever theme you apply for a consistent look.

### KDE Script

This script is provided "as is" to an even greater extent than the rest. I don't use KDE, but it should work fine.

# Additional Scripts
If you use Debian (as I used to), check out the far lower quality;

https://github.com/SomeWaffleGuy/debscript

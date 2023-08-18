# VEC foot pedal Linux

**A collection of udev rules and helpful scripts for Linux users**

All credit for this solution goes to A. Cynic from [The Cat's Whisker](https://catswhisker.xyz/) for their excellent post [Use VEC/Infinity USB Foot Pedal as a Keyboard Under Linux](https://catswhisker.xyz/log/2018/8/27/use_vecinfinity_usb_foot_pedal_as_a_keyboard_under_linux/) and [Gabor Karsay](https://github.com/gkarsay) for an [enlightening answer](https://github.com/gkarsay/parlatype/issues/28#issuecomment-356307490) under [Parlatype](https://github.com/gkarsay/parlatype/)'s discussion page. I'm merely gathering these resources here so I don't have to re-read and reconstruct the whole process every time I fry a machine ;)

![VEC foot pedal](https://github.com/userexec/VEC-foot-pedal-linux/assets/5970137/c837d3eb-a117-4eee-b6d2-9e2c99e2cbd1)


## Recognizing the foot pedal

To use the VEC foot pedal, first install the udev rules for this device so that it's recognized when plugged in. The VEC foot pedal does not work by default under Linux. In Ubuntu, these rules should be placed at the following locations:

  - /etc/udev/rules.d/10-vec-usb-footpedal.rules
  - /etc/udev/hwdb.d/90-vec-usb-footpedal.hwdb

## Changing the key assignments

The VEC foot pedal has three pedals on it. These are mapped to keys in `90-vec-usb-footpedal.hwdb`.

The default mapping is:

  - `KEYBOARD_KEY_90001` - `leftmeta`
  - `KEYBOARD_KEY_90002` - `f15`
  - `KEYBOARD_KEY_90003` - `f16`

The format here is `KEYBOARD_KEY_<scan_code>=<key_code>`. If the device is not working, you may need to change your scan code.

Scan codes can be found using `sudo evtest` then selecting the device number for "VEC  VEC USB Footpedal". Press the pedals to receive the correct scan code at the end of the line after "value" for example:

```
Event: time 1692309275.649421, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90002
```

To find supported key codes, check `/usr/include/linux/input-event-codes.h`. The foot pedal's scan code should be assignable to any key code. Note that the key codes in this file are preceded by KEY_ and in all caps. The key code needed is *only the part after KEY_, converted to lowercase* (e.g. KEY_LEFTMETA becomes leftmeta).

## Assigning scripted actions to the key combinations

For scripted interactions when pressing the foot pedal, assign the appropriate scripts to keyboard shortcuts in your desktop environment's keyboard settings menu. This repository includes 5 helpful scripts to get started, though the pedal can trigger any script you write.

  - `nextworkspace.sh` - changes to the next workspace
  - `prevworkspace.sh` - changes to the previous workspace
  - `activetonext.sh` - moves the active window to the next workspace and changes to that workspace
  - `activetoprev.sh` - moves the active window to the previous workspace and changes to that workspace
  - `toggleoverview.sh` - activates the overview, same as pressing the Super key in GNOME

Note that `toggleoverview.sh` is specific to GNOME and should not be assigned if you're just using this project's udev rules as written--the hwdb rules specify KEYBOARD_KEY_90001 as leftmeta, so it's set to be the Super key by default. Only assign a keyboard shortcut to `toggleoverview.sh` if you're changing your pedal's key assignment in `90-vec-usb-footpedal.hwdb`.

The other scripts rely on `wmctrl`.
# Hakchi2 CE on Linux

Hakchi2 CE is a Windows Forms app. On Linux it runs under [Mono](https://www.mono-project.com/).
Linux support is new and has had little testing with real consoles, so **try memboot / adding games and
syncing before you flash a custom kernel**, and keep your NAND backup safe.

## 1. Install dependencies

| Distro | Command |
| --- | --- |
| Arch, Manjaro, EndeavourOS | `sudo pacman -S mono libgdiplus libusb` |
| Debian, Ubuntu, Mint, Pop!_OS | `sudo apt install mono-complete libgdiplus libusb-1.0-0` |

Other distros: install Mono (including its WinForms library), libgdiplus and libusb 1.0 from your package manager.

## 2. Allow USB access (once)

```sh
sudo cp 99-hakchi.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
```

Unplug and replug the console afterwards.

## 3. Run

Extract the archive somewhere you can write to (for example `~/hakchi2-ce`); settings and games are kept
next to the program. Then:

```sh
./hakchi.sh
```

## Notes and known limitations

- **Driver install button:** that's a Windows-only step. On Linux the udev rule above replaces it.
- **Network (SSH) connection:** once hakchi is installed, the console shows up as a USB Ethernet device.
  If hakchi stays "Offline", set that connection's IPv4 method to **Link-Local Only** in your network settings.
- **FTP / Telnet menu items** open with `xdg-open`. You can change the commands in `config.ini`
  (`FtpCommand`, `TelnetCommand`).
- **Readme / message-of-the-day panels** use plain text instead of the embedded browser.
- **SFROM Tool** is a Windows program and is not available.

## Building from source

Needs the .NET SDK (8 or newer), Mono (for `resgen`) and `wget`:

```sh
git submodule update --init --recursive
dotnet build hakchi_gui/hakchi_gui.csproj -c Release
cp linux/hakchi.sh linux/99-hakchi.rules linux/README-linux.md hakchi_gui/bin/Release/net48/
```

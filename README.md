# Hakchi2 CE

Hakchi2 CE lets you add more games to your NES Classic Mini and SNES Classic Mini (and their Famicom/Super
Famicom variants). This is a fork of [TeamShinkansen/Hakchi2-CE](https://github.com/TeamShinkansen/Hakchi2-CE)
that adds **Linux support**.

## Windows

Download the build from the latest successful run on the [Actions tab](https://github.com/DuBearte/Hakchi2-CE/actions):
`hakchi2-ce-…-portable` (unzip and run `hakchi.exe`) or `hakchi2-ce-…-installer`.

## Linux

Hakchi2 CE runs on Linux under Mono. It has been tested on Arch (Omarchy) with a SNES Classic: connecting,
adding games and syncing all work. Download `hakchi2-ce-linux` from the
[Actions tab](https://github.com/DuBearte/Hakchi2-CE/actions), then follow
**[the Linux guide](linux/README-linux.md)** for dependencies, USB access, network setup and troubleshooting.

## Building

- **Windows:** open `hakchi_gui.sln` in Visual Studio, or see `.github/workflows/dotnet-desktop.yml`.
- **Linux:** see [Building from source](linux/README-linux.md#building-from-source) in the Linux guide.

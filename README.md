# nixos config

this repository contains my nixos configuration for an Intel + NVIDIA workstation. it manages the system, desktop, development tools, user environment, and maintenance jobs through one flake.

## workstation

| area | configuration |
|---|---|
| system | nixos 26.05 on `x86_64-linux` |
| boot | systemd-boot with efi |
| desktop | gnome with gdm |
| graphics | nvidia stable proprietary driver |
| audio | pipewire with pulseaudio and 32-bit alsa support |
| network | networkmanager |
| shell | zsh, starship, zoxide, fzf, and direnv |
| development | node.js, python, rust, c, and c++ |
| containers | docker with compose |
| user environment | home manager integrated into nixos |

the system compatibility version is `25.11`, matching the original installation. nixpkgs and home manager use their matching `26.05` release branches and are pinned in `flake.lock`.

## how it works

`flake.nix` defines one host named `nixos`. the system configuration imports hardware, desktop, development, package, and maintenance modules. home manager is evaluated as part of the system build and manages the `kush` user environment.

the flake exposes the nixos system as a check. running `nix flake check` evaluates and builds the system closure used by `nixos-rebuild`.

```text
flake.nix
├── nixos host: nixos
│   ├── hardware configuration
│   ├── gnome and nvidia graphics
│   ├── development toolchains
│   ├── system packages
│   └── automatic maintenance
└── home manager: kush
    ├── desktop applications
    ├── shell environment
    └── rebuild and backup automation
```

## rebuilding

home manager adds a `rebuild` command for updating the system:

```console
rebuild
```

it runs these steps in order:

1. stages new files so the flake can see them.
2. formats the nix source with `nix fmt`.
3. validates the configuration with `nix flake check`.
4. activates the validated system with `nixos-rebuild switch`.
5. commits and pushes the resulting configuration.

a repository lock prevents manual rebuilds and automatic backups from committing at the same time.

## automation

a persistent home manager user timer commits and pushes configuration changes every day at 23:30. missed runs are picked up when the user timer starts again.

a system timer runs weekly maintenance. it keeps the latest three nixos generations, refreshes the boot entries, and garbage-collects unreachable store paths.

## development environment

the workstation includes:

- node.js 22 and pnpm
- python, uv, and direnv with nix-direnv
- rust through rustup
- gcc, clang, cmake, make, and pkg-config
- docker and docker compose
- github cli, lazygit, ripgrep, fd, jq, and common system tools
- `nix-ld` with desktop and runtime libraries for prebuilt linux binaries

desktop applications are managed through home manager, including firefox, chrome, vs code, spotify, discord, kitty, and gnome utilities.

## repository layout

```text
.
├── flake.nix                    # inputs, host definition, formatter, and checks
├── flake.lock                   # pinned nixpkgs and home manager revisions
├── configuration.nix           # core system configuration and module imports
├── hardware-configuration.nix  # filesystems, initrd, cpu, and platform settings
├── home.nix                    # home manager entry point
├── home
│   ├── apps.nix                # browsers, desktop apps, and terminal tools
│   ├── automation.nix          # rebuild command and daily backup timer
│   └── shell.nix               # zsh and interactive shell tools
└── modules
    ├── desktop.nix             # gnome, nvidia, pipewire, fonts, and printing
    ├── development.nix         # toolchains and docker
    ├── maintenance.nix         # generation cleanup and garbage collection
    └── packages.nix            # system utilities and nix-ld libraries
```

## using this configuration

the repository uses `/home/kush/nixos-config` and the hardware described in `hardware-configuration.nix`. using it on another machine requires changes to the username, home path, hostname, filesystem uuids, cpu settings, and graphics configuration.

to validate the current host configuration:

```console
nix flake check
```

to activate it directly:

```console
sudo nixos-rebuild switch --flake .#nixos
```

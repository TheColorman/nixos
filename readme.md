# Nix config

my nix configs and update script

## Layout

- `dependencies/` - Flake dependencies I need locally for whatever reason, as submodules.
- `flakes/` - Programs not packaged in `nixpkgs` that I couldn't be bothered to split into their own repo. Might change how this works and is imported at some point.
- `hosts/` - Configuration for each machine.
  - `framework/` - My Framework laptop. Only host for now.
- `modules/` - Nix [modules](https://nixos.wiki/wiki/Module) exposed as an output in `flake.nix`, which allows me to import them in host configurations or in other modules.
  - `apps/` - Each file enables a single application, along with my preffered configuration. If I want an application with its default configuration I won't create a separate app file for it.
  - `containers/` - NixOS containers, they can import other modules.
  - `patches/` - Git patches to change the source of any imported package.
  - `profiles/` - Collections of several apps and extra config.
  - `system/` - Configs for system features that aren't necessarily applications, e.g. fonts.

## todo

- [ ] Add `~/.config/fcitx5` to home-manager.
- [ ] Use `stylix` colors in `oh-my-posh` config.
- [ ] Vim setup.
  - [ ] Adapt Vim binds for Colemak Curl (DH-mod)
  - [ ] Sane defaults (tab-width, line numbers etc.)
- [ ] Add config path option to oh-my-posh to allow different configs (for containers).

### toDONE

- [x] Add [`sops-nix`](https://github.com/Mic92/sops-nix) for managing secrets.
- [x] Fix the fucking mess of a config.
- [x] Turn `*nix` aliases into scripts.
- [x] Merge `nixosModules` and `homeManagerModules` directories, mimicking [`MatthewCroughan/nixcfg`](https://github.com/MatthewCroughan/nixcfg)

# configuration.nix
{
  pkgs,
  inputs,
  system,
  ...
}: let
  pkg = name: inputs.${name}.packages.${system}.default;
in {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./user-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "color" = import ./home.nix;
    };
  };

  environment.systemPackages = with pkgs; [
    python312Packages.pygments
    input-remapper
    aria2
    (pkg "fw-ectool")
    fprintd
    zinit
  ];

  environment.pathsToLink = ["/share/zsh"];
  services.input-remapper.enable = true;
  services.fwupd.enable = true;
  hardware.bluetooth.enable = true;
}

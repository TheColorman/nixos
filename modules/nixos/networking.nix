{...}: {
  networking.hostName = "colornix";
  networking.networkmanager.enable = true;

  # Patch for connecting to legacy eduroam networks
  nixpkgs.config.packageOverrides = pkgs: rec {
    wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (oldAttrs: {
      patches = oldAttrs.patches ++ [./eduroam.patch];
    });
  };

  # Prevent networkmanager from managing nix containers
  networking.networkmanager.unmanaged = ["interface-name:ve-*"];
}
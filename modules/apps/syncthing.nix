{ pkgs, config, ... }:
let
  user = config.my.username;
in
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.devices = {
      "colordesktop" = {
        addresses = [ "dynamic" ];
        id = "MCFUD3B-ZCXDBVJ-H243LXH-V3N6CEK-IT6PW6E-2EMYKH2-FURKLOT-546OQAQ";
      };
      "colorcloud" = {
        addresses = [
          "tcp://192.168.50.222:20978"
          "tcp://192.168.50.222:20979"
          "quic://192.168.50.222:20978"
          "quic://192.168.50.222:20979"
        ];
        id = "HRE2PWX-SNH52Z7-4YWWZRK-GX5IJ5V-SNYBZOY-P4NHNWC-TDBV5ZY-MKZLKA7";
      };
      "colorphone" = {
        addresses = [ "dynamic" ];
        id = "FUHS52Q-W6FORIW-OP4737B-RI5FP4Z-KCHL3U6-C2CF7HG-OKMQAU6-AJJYOA3";
      };
    };
    settings.folders = {
      brain = {
        devices = [ "colordesktop" "colorcloud" "colorphone" ];
        id = "yedar-6vrrr";
        path = "/home/${user}/brain";
      };
      CTF = {
        devices = [ "colordesktop" "colorcloud" ];
        id = "dh6gy-zxqu6";
        path = "/home/${user}/CTF";
      };
      ITU = {
        devices = [ "colordesktop" "colorcloud" ];
        id = "yc39s-4wtgc";
        path = "/home/${user}/ITU";
      };
      Documents = {
        devices = [ "colordesktop" "colorcloud" "colorphone" ];
        id = "wt32c-t7rkv";
        path = "/home/${user}/Documents";
      };
    };
  };
  system.activationScripts.syncthingSetup.text = ''
    mkdir -p /home/${user}/brain
    mkdir -p /home/${user}/CTF
    mkdir -p /home/${user}/ITU
    mkdir -p /home/${user}/Documents

    setfacl=${pkgs.acl}/bin/setfacl

    $setfacl -Rdm u:syncthing:rwx /home/${user}/brain
    $setfacl -Rdm u:syncthing:rwx /home/${user}/CTF
    $setfacl -Rdm u:syncthing:rwx /home/${user}/ITU
    $setfacl -Rdm u:syncthing:rwx /home/${user}/Documents
    $setfacl -Rm u:syncthing:rwx /home/${user}/brain
    $setfacl -Rm u:syncthing:rwx /home/${user}/CTF
    $setfacl -Rm u:syncthing:rwx /home/${user}/ITU
    $setfacl -Rm u:syncthing:rwx /home/${user}/Documents

    $setfacl -Rdm u:${user}:rwx /home/${user}/brain
    $setfacl -Rdm u:${user}:rwx /home/${user}/CTF
    $setfacl -Rdm u:${user}:rwx /home/${user}/ITU
    $setfacl -Rdm u:${user}:rwx /home/${user}/Documents
    $setfacl -Rm u:${user}:rwx /home/${user}/brain
    $setfacl -Rm u:${user}:rwx /home/${user}/CTF
    $setfacl -Rm u:${user}:rwx /home/${user}/ITU
    $setfacl -Rm u:${user}:rwx /home/${user}/Documents

    $setfacl -m u:syncthing:--x /home/${user}
  '';
  environment.systemPackages = with pkgs; [ syncthing ];
}

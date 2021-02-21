pkgs: {
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    cleanTmpDir = true;
    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems."/mnt/win" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
    options = [ "rw" "uid=uwe" ];
  };
}

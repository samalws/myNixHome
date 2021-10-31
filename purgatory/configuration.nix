# text of /etc/nixos/configuration.nix is: "import /home/uwe/purgatory/configuration.nix"

let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/34ad3ffe08adfca17fcb4e4a47bb5f3b113687be.tar.gz";
    sha256 = "sha256:02li241rz5668nfyp88zfjilxf0mr9yansa93fbl38hjwkhf3ix6";
  }) {};
  hardware = import ./nonAutoHardwareConfig.nix;
in {
  networking = {
    hostName = "nixos-uwe";
    firewall.enable = false;
    wireless = {
      enable = true;
      userControlled.enable = true;
      networks = import ./networks.nix;
      interfaces = [ "wlp2s0" ];
    };
  };

  time.timeZone = "America/Chicago";

  services = {
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "us,de,il"; # , ru
      xkbOptions = "grp:caps_toggle";
      libinput.enable = true;
      desktopManager.xterm.enable = false;
      displayManager.startx.enable = true;
    };
    acpid.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  users.users.uwe = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };

  nix = {
    trustedUsers = [ "root" "uwe" ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  programs.slock.enable = true;
  programs.light.enable = true;
  services.upower.enable = true;
  # programs.gnupg.agent.enable = true;

  fonts.fonts = with pkgs; [
    ubuntu_font_family
  ];

  system.stateVersion = "20.03";
} // (hardware pkgs)

# text of /etc/nixos/configuration.nix is: "import /home/uwe/purgatory/configuration.nix"

{ config, pkgs, ... }:
let
 mySt  = import ./mySt/st.nix;
 myDwm = import ./myDwm/dwm.nix;
in {
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

  networking = {
    hostName = "nixos-uwe";
    networkmanager.enable = true;
    firewall.enable = false;
    wireless.userControlled.enable = true;
  };

  time.timeZone = "America/Chicago";

  services = {
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "us,de,ru";
      xkbOptions = "grp:caps_toggle";
      libinput.enable = true;
      desktopManager.xterm.enable = false;
      displayManager.startx.enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  fileSystems."/mnt/win" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
    options = [ "rw" "uid=uwe" ];
  };

  users.users.uwe = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    # shell = pkgs.dash;
  };

  nixpkgs.config.allowUnfree = true;

  # services.openvpn.servers.privatvpn.config = '' config /etc/openvpn/privatvpn.conf  '';

  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  programs.slock.enable = true;
  programs.light.enable = true;
  services.upower.enable = true;
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    ed
    firefox
    dmenu
    surf
    zoom-us
    obs-studio
    mpv
    openvpn
    redshift
    ntfs3g
    ghc
    git
    dash
    mupdf
    texlive.combined.scheme-small
    feh
    pamixer
    rtorrent
    upower
    vim
    mySt
    myDwm
  ];

  fonts.fonts = with pkgs; [
    ubuntu_font_family
  ];

  system.stateVersion = "20.03";
}

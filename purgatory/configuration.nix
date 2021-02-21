# text of /etc/nixos/configuration.nix is: "import /home/uwe/purgatory/configuration.nix"

{ pkgs, ... }:
let
 mySt  = import ./myStNix/st.nix;
 myDwm = import ./myDwmNix/dwm.nix;
 hardware = import ./nonAutoHardwareConfig.nix;
in {
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
} // (hardware pkgs)

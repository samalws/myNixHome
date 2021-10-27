# text of /etc/nixos/configuration.nix is: "import /home/uwe/purgatory/configuration.nix"

{ pkgs, ... }:
let
 mySt  = import ./myStNix/st.nix;
 myDwm = import ./myDwmNix/dwm.nix;
 hardware = import ./nonAutoHardwareConfig.nix;
 androidSdk = pkgs.androidenv.androidPkgs_9_0.androidsdk;
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

  time.timeZone = "America/New_York";

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
    # shell = pkgs.dash;
  };

  nixpkgs.config.allowUnfree = true;

  #services.openvpn.servers.privatevpn.config = " config /home/uwe/purgatory/privatevpn/UDP/PrivateVPN-SE-Stockholm-TUN-1194.ovpn  ";

  #virtualisation.virtualbox = {
  #  host = {
  #    enable = true;
  #    enableExtensionPack = true;
  #  };
  #};

  programs.slock.enable = true;
  programs.light.enable = true;
  services.upower.enable = true;
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    ed
    firefox
    brave
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
    lxqt.screengrab
    coq
    gimp
    neomutt
    zip
    unzip
    youtube-dl
    wireshark
    bind
    discord
    inetutils
    thunderbird
    pavucontrol
    dragon-drop
    wpa_supplicant_gui
    direnv
    acpid
  ];

  fonts.fonts = with pkgs; [
    ubuntu_font_family
  ];

  system.stateVersion = "20.03";
} // (hardware pkgs)

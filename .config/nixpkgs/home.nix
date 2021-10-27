{ pkgs, ... }:
let
  mySt  = import ~/purgatory/myStNix/st.nix;
  myDwm = import ~/purgatory/myDwmNix/dwm.nix;
in {
  programs.home-manager.enable = true;

  home.username = "uwe";
  home.homeDirectory = "/home/uwe";

  nixpkgs.config.allowUnfree = true;

  programs.gpg.enable = true;

  home.packages = with pkgs; [
    light
    firefox
    brave
    dmenu
    zoom-us
    obs-studio
    mpv
    redshift
    git
    mupdf
    texlive.combined.scheme-small
    feh
    pamixer
    upower
    vim
    mySt
    myDwm
    lxqt.screengrab
    gimp
    neomutt
    zip
    unzip
    dragon-drop
    wpa_supplicant_gui
    direnv
    acpid # what?
  ];

  home.stateVersion = "21.05";
}

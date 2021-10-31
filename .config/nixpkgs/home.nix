{ pkgs, ... }:
let
  mySt  = import ~/purgatory/myStNix/st.nix;
  myDwm = import ~/purgatory/myDwmNix/dwm.nix;
in {

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };

  home = {
    username = "uwe";
    homeDirectory = "/home/uwe";
    packages = with pkgs; [
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
      acpid # what?
    ];
  };

  home.stateVersion = "21.05";
}

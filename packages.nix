{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  wget vim i3 git firefox thunderbird feh rxvt_unicode emacs keepass zotero taskwarrior htop tmux conda julia zsh psmisc tree gnumake gfortran binutils
  ];

}

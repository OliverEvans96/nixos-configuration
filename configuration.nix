## Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gui.nix
    ];

  boot = {
    # Use the GRUB 2 boot loader.
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };

    # Encrypted root
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/8c79e094-0a16-46ed-ae12-b945f127418e";
        preLVM = true;
        allowDiscards = true;
      }
    ];
  };

  networking.hostName = "oliver-nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim i3 git firefox thunderbird feh rxvt_unicode emacs keepass zotero taskwarrior htop tmux conda julia zsh psmisc tree gnumake gfortran binutils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List services that you want to enable:
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;



    logind.extraConfig = ''
        HandleLidSwitch=ignore
        HandlePowerKey=suspend
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oliver = {
    isNormalUser = true;
    home = "/home/oliver";
    description = "Oliver Evans";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}

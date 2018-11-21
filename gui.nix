{pkgs,...}:

{
  services = {
    # Enable the X11 windowing system.
    xserver = {
      # Enable X11
      enable = true;
      layout = "us";
      #
      # Disable standard DMs/xterm
      desktopManager = {
      default = "none";
      xterm.enable = false;
      };

      # Enable i3
      windowManager.default = "i3";
      windowManager.i3.enable = true;

      displayManager.sessionCommands = ''
      ${pkgs.rxvt_unicode}/bin/urxvtd -q -o -f
      ${pkgs.emacs}/bin/emacs --daemon
      '';
      # Enable touchpad support.
      libinput.enable = true;
    };
  };
}

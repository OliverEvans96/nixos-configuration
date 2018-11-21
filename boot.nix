{ ... }:

{
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
}

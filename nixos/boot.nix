{pkgs, ...}:
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
  };
  boot.initrd.systemd.enable = true;
}
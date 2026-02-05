{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/c3";
      fsType = "btrfs";
      options = [ "subvol=nixos" ];
    };


  boot.initrd.luks.devices = {
        c1 = {
                device = "/dev/disk/by-uuid/acfd84bf-57d3-4861-bf0e-bdb439914e90";
                allowDiscards = true;
        };
        c2 = {
                device = "/dev/disk/by-uuid/2637479b-f5c9-4292-bd73-a6d008add595";
                allowDiscards = true;
        };
        c3 = {
                device = "/dev/disk/by-uuid/304973dd-9fb5-45fd-824a-c2a948af0ecf";
                allowDiscards = true;
        };
        swap = {
                device = "/dev/disk/by-uuid/195a764d-3bc7-4cc5-8584-e3d2d6a1dece";
                allowDiscards = true;
        };
  };

  fileSystems."/home" =
    { device = "/dev/mapper/c3";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/f6286dc8-eea4-4662-b92a-b2ea0992d6ca";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/363C-6B10";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/swap"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

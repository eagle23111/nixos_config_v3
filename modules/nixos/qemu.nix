{ config, inputs, pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    usbredir

    inputs.winapps.packages."${system}".winapps
    inputs.winapps.packages."${system}".winapps-launcher 
  ];
}

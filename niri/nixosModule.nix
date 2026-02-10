{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
    inputs.stylix.nixosModules.stylix
  ];
  nixpkgs.overlays = [inputs.niri.overlays.niri];

  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
    thunar-vcs-plugin
  ];

  services.flatpak.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  #services.power-profiles-daemon.enable or services.tuned.enable = true;
  #services.upower.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
    xwayland-satellite
    playerctl
    file-roller
    mate.mate-polkit
    ddcutil
  ];
  hardware.i2c.enable = true;
  boot.kernelModules = ["i2c-dev"]; # monitor lights

  programs.light.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    vanilla-dmz
    numix-icon-theme
    numix-icon-theme-circle
    gnome-tweaks
    unstable.rewaita
  ];

  fonts.packages = with pkgs; [nerd-fonts.terminess-ttf];
}

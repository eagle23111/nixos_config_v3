{pkgs,inputs, ...}:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    vanilla-dmz
    numix-circle
    gnome-tweaks
    rewaita
  ];

  fonts.packages = with pkgs; [ nerd-fonts.terminess-ttf ];
}
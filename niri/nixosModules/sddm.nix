{pkgs, ...}: {
  /*
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
  };
  */
  services.displayManager.ly.enable = true;

  #environment.systemPackages = [
  #  pkgs.kdePackages.qtmultimedia
  #];
}

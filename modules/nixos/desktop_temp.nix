{pkgs, inputs,...}:
{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
    inputs.niri.nixosModules.niri
    ];
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    #enableClipboard = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;

    dgop.package = pkgs.unstable.dgop;
  };

  programs.niri = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    alacritty
    xwayland-satellite
  ];
}
{inputs, pkgs, ...}:
 { 
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.niri.homeModules.niri
  ];
  programs.dank-material-shell = {
    enable = true;
    dgop.package = pkgs.unstable.dgop;
    # Core features
    # niri integration
    niri = {
      enableSpawn = false;   # DMS will start niri automatically
      enableKeybinds = false;  # Prefer config includes (more flexible)
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";
        filesToInclude = [ "binds" "layout" "outputs" ];
      };
    };

    settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };

}
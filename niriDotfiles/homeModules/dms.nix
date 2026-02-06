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
      enableSpawn = true;   
      #enableClipboard = true;
      enableKeybinds = false;  
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";
            filesToInclude = [         # Files under `$XDG_CONFIG_HOME/niri/dms` to be included into the new config
      "alttab"                 # Please note that niri will throw an error if any of these files are missing.
      "binds"
      "colors"
      "layout"
      "outputs"
      "wpblur"
      "cursor"
    ];
      };
    };
    

    settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };
}

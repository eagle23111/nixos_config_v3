{pkgs, ...}:
let 
    lockcommand = "noctalia-shell ipc call lockScreen lock";
in {
services.swayidle = {
  enable = true;
  package = pkgs.swayidle;  # Or pkgs.niri if adapted for compositor commands

  timeouts = [
    { timeout = 330; command = lockcommand; }
    { timeout = 360; command = "niri msg action power-off-monitors";  
      resumeCommand = "niri msg action monitors-on"; }
  ];

  events = [
    { event = "before-sleep"; command = lockcommand; }
    { event = "after-resume"; command = lockcommand; }
  ];
};
}

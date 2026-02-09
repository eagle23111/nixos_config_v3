{pkgs, ...}:
let
hydrus-companion = pkgs.fetchgit {
  url = "https://gitgud.io/your-username/your-repo.git";
  rev = "789235938b756c7ef0a001bec95166518ed39f90"; # full commit hash
  sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # obtained via --show-trace or nix-prefetch-git
};
in
{
  programs.chromium = {
    enable = true;
    extensions = 
      [{
        Path = "${hydrus-companion}";
      }];
  };
}
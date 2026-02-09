{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # inputs.self.homeManagerModules.example
    # inputs.nix-colors.homeManagerModules.default

    inputs.self.homeManagerModules.zsh
    inputs.self.niri.homeManagerModule
    #inputs.self.niriDotfiles.homeManagerModule
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # neovim-nightly-overlay.overlays.default

      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "mortal";
    homeDirectory = "/home/mortal";
  };

  home.packages = with pkgs; [
    steam
    #protonup-qt
    gamemode
    gamescope
    prismlauncher
    inputs.zen-browser.packages.${system}.default
    wineWowPackages.stable
    winetricks
    vscode

    tor
    tor-browser

    libreoffice-fresh

    devenv
    openssl

    llama-cpp
    lmstudio
    inputs.nvchad4nix.packages.${system}.default

    unstable.hydrus

    evolution

    ani-cli
    mpv
  ];
  programs.lutris = {
    enable = true;
  };

  programs.kitty = {
  enable = true;
  extraConfig = ''
      copy_on_select yes
      mouse_map right press ungrabbed,grabbed paste_from_selection
    '';
  };


  programs.home-manager.enable = true;
  services.gnome-keyring.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true; # for huggingface
    settings = {
      user = {
        name = "eagle23111";
        email = "stasapohta@yandex.ru";
      };
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

#TODO: kill it with fire
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = [
    (pkgs.buildFHSEnvironment {
      name = "full-distro-fhs";

      targetPkgs = pkgs: with pkgs; [
        glibc
        zlib
        bzip2
        xz
        pcre
        libffi

        (with pkgs.xorg; [
          libX11
          libXext
          libXrender
          libXrandr
          libXinerama
          libXcursor
          libXScrnSaver
          libXi
          libxcb
          libxshmfence
          libGL
          libGLU
        ])
        mesa
        libvdpau

        alsa-lib
        libpulseaudio

        libvorbis
        libogg
        flac
        libjpeg
        libpng
        freetype
        fontconfig
        libtheora
        libvpx
        ffmpeg

        openssl
        curl
        nspr
        nss
        libidn

        #sqlite
        gdbm
        gmp
        libxml2
        expat
        icu

        gcc.cc.lib
        stdenv.cc.cc.lib  
        binutils

        #wayland
        libxkbcommon

        gtk3
        glib
        dbus
        #systemd
        udev
        e2fsprogs
      ];

      multiPkgs = pkgs: with pkgs; [
        gcc.cc.lib
        (with pkgs.xorg; [ libX11 libXext libXrender libXrandr ])
        alsa-lib
        libpulseaudio
        libGL
        libvorbis
        libogg
        zlib
        openssl
        dbus
        glib
      ];

      runScript = "zsh";

      extraBuildCommands = ''
        # Ensure /usr/bin/env exists
        mkdir -p $out/usr/bin
        ln -s /bin/env $out/usr/bin/env
      '';
    })
  ];

  #shellHook = ''
  #'';
}

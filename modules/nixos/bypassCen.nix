{pkgs, inputs, ...}:
 let
  unstableWithZapret = import inputs.nixpkgs-unstable {
    system = pkgs.system;  # or "x86_64-linux", etc.
    config.allowUnfree = true;
    overlays = [ (import ../../overlays/zapret-overlay.nix) ];
  };
in
{
  services.zapret = {
    enable = true;
    package = unstableWithZapret.zapret;
    params = [
      "--filter-tcp=80,443"
      "--hostlist-domains=googlevideo.com,googleapis.com"
      "--ip-id=zero"
      "--dpi-desync=fake,multisplit"
      "--dpi-desync-split-seqovl=681"
      "--dpi-desync-split-pos=1"
      "--dpi-desync-fooling=ts"
      "--dpi-desync-repeats=8"
      "--dpi-desync-split-seqovl-pattern=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/tls_clienthello_www_google_com.bin"
      "--dpi-desync-fake-tls=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/tls_clienthello_www_google_com.bin"
      "--new"
      "--filter-tcp=80,443"
      "--dpi-desync=fake,multisplit"
      "--dpi-desync-split-seqovl=664"
      "--dpi-desync-split-pos=1"
      "--dpi-desync-fooling=ts"
      "--dpi-desync-repeats=8"
      "--dpi-desync-split-seqovl-pattern=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/tls_clienthello_max_ru.bin"
      "--dpi-desync-fake-tls=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/tls_clienthello_max_ru.bin"
      "--new"
      "--filter-udp=80,443"
      "--dpi-desync=fake"
      "--dpi-desync-repeats=10"
      "--dpi-desync-fake-quic=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/quic_initial_www_google_com.bin"
    ];
    whitelist = [
        "googleusercontent.com"
        "accounts.google.com"
        "googleadservices.com"
        "googlevideo.com"
        "gvt1.com"
        "jnn-pa.googleapis.com"
        "play.google.com"
        "wide-youtube.l.google.com"
        "youtu.be"
        "youtube-nocookie.com"
        "youtube-ui.l.google.com"
        "youtube.com"
        "youtube.googleapis.com"
        "youtubeembeddedplayer.googleapis.com"
        "youtubei.googleapis.com"
        "yt-video-upload.l.google.com"
        "yt.be"
        "ytimg.com"
        "ggpht.com"
      ];
    configureFirewall = true;
  };
}
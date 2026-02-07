{
  pkgs,
  inputs,
  ...
}: {
  services.zapret = {
    enable = true;
    package = pkgs.unstable.zapret;
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
      "--filter-udp=80,443"
      "--dpi-desync=fake"
      "--dpi-desync-repeats=10"
      "--dpi-desync-fake-quic=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/quic_initial_www_google_com.bin"
      "--new"
      "--filter-tcp=80,443"
      "--dpi-desync=fake,multisplit"
      "--dpi-desync-split-seqovl=664"
      "--dpi-desync-split-pos=1"
      "--dpi-desync-fooling=ts"
      "--dpi-desync-repeats=8"
      "--dpi-desync-fake-tls=${pkgs.unstable.zapret}/usr/share/zapret/files/fake/tls_clienthello_max_ru.bin"
    ];
    blacklist = [
      "qwen.ai"
      "aliyuncs.com"
    ];
  };
  services.cloudflare-warp.enable = true;
}

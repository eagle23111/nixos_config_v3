# ./overlays/zapret-overlay.nix
final: prev: {
  zapret = prev.zapret.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ final.fetchurl ];

    tlsClientHelloFake = final.fetchurl {
      url = "https://github.com/Flowseal/zapret-discord-youtube/raw/refs/heads/main/bin/tls_clienthello_max_ru.bin";
      sha256 = "<placeholder-for-sha256>";
    };

    installPhase = ''
      ${oldAttrs.installPhase or ""}
      mkdir -p $out/usr/share/zapret/files/fake
      cp ${tlsClientHelloFake} $out/usr/share/zapret/files/fake/tls_clienthello_max_ru.bin
    '';
  });
}
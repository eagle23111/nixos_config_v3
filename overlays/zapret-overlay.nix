final: prev: {
  zapret = prev.zapret.overrideAttrs (oldAttrs: 
    let
      tlsClientHelloFake = final.fetchurl {
        url = "https://github.com/Flowseal/zapret-discord-youtube/raw/refs/heads/main/bin/tls_clienthello_max_ru.bin";
        sha256 = "4ee0870abe0a0128600b0095189987ba1d210dae8bf963bc725aff49cf922624";
      };
    in
    {
      installPhase = ''
        ${oldAttrs.installPhase or ""}
        mkdir -p $out/usr/share/zapret/files/fake
        cp ${tlsClientHelloFake} $out/usr/share/zapret/files/fake/tls_clienthello_max_ru.bin
      '';
    }
  );
}
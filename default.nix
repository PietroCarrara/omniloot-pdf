{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f480f9d09e4b4cf87ee6151eba068197125714de.tar.gz") { }
}:
with pkgs;

stdenv.mkDerivation rec {
  name = "omniloot-pdf";
  src = ./.;

  buildInputs = [
    sile
    (python3.withPackages (pip: [
      pip.beautifulsoup4
    ]))
  ];

  buildPhase = ''
    python extract-data.py
    sile main.sil
  '';

  installPhase = ''
    mkdir -p "$out"
    cp main.pdf "$out/"
  '';
}

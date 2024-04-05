{ pkgs ? import <nixpkgs> { }
}:

pkgs.stdenv.mkDerivation {
  name = "omniloot-pdf";
  src = ./.;

  buildInputs = [
    (pkgs.python3.withPackages (pip: [
      pip.beautifulsoup4
    ]))
  ];
}

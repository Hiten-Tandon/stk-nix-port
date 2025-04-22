{
  description = "STK port for nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; }; {
        packages.default = stdenv.mkDerivation (finalAttrs: {
          pname = "stk";
          version = "5.0.1";

          src = fetchTarball {
            url = "http://ccrma.stanford.edu/software/stk/release/stk-5.0.1.tar.gz";
            sha256 = "0pmp45hj4a4638wz88wxh8d5vhghk779zd3jw7a6b3v8qsa1620m";
          };

          nativeBuildInputs = [ cmake gnumake pkg-config alsa-lib jack2 ];

          preBuildPhase = ''
            cd $out
            ./configure --with-oss --with-alsa --with-jack
          '';

          meta = {
            description =
              "The Synthesis ToolKit in C++ (STK) is a set of open source audio signal processing and algorithmic synthesis classes written in the C++ programming language.";
            homepage = "https://ccrma.stanford.edu/software/stk";
            license = lib.licenses.stk;
          };
        });
        formatter = nixfmt-classic;
      });
}

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

          src = fetchFromGitHub {
            owner = "thestk";
            repo = "stk";
            rev = "5.0.1";
            sha256 = "y84OfOWFdARZApm8VHz4yjl8/7SActNVUHgvSUkwJnw=";
          };

          nativeBuildInputs = [ cmake gnumake pkg-config alsa-lib ];

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

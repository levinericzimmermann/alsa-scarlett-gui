{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;

stdenv.mkDerivation {
    name = "alsa-scarlett-gui";
    src = ./src;
    nativeBuildInputs = [ wrapGAppsHook pkg-config ];
    propagatedBuildInputs = [
        gnumake
        alsa-lib
        gtk4
        pkg-config
        openssl
        gvfs
    ];
    buildPhase = ''
      NIX_CFLAGS_COMPILE="$(pkg-config --cflags gtk4) $NIX_CFLAGS_COMPILE"
    '';
    makeFlags = [
      "DESTDIR=$(out)"
      "-j4"
    ];
}

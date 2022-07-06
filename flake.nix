{
  description = "Flake for ocs-url with ocs:// support";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = inputs@{ self, nixpkgs, ...}: {
    packages.x86_64-linux.default =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in 
        pkgs.stdenv.mkDerivation rec {
          name = "ocs-url";
          srcs = [
            (pkgs.fetchgit {
                url = "https://www.opencode.net/dfn2/ocs-url.git";
                rev = "refs/tags/release-3.1.0";
                sha256 = "RvbkcSj8iUAHAEOyETwfH+3XnCCY/p8XM8LgVrZxrws=";
            })

            (pkgs.fetchgit {
              url = "https://github.com/akiraohgaki/qtil";
              rev = "refs/tags/v0.4.0";
              sha256 = "XRSp0F7ggfkof1RNAnQU3+O9DcXDy81VR7NakITOXrw=";
            })
          ];
          sourceRoot = "ocs-url";
          dontWrapQtApps = true;

          buildInputs = with pkgs.libsForQt5.qt5; [
            qtbase
            qtsvg
            qtquickcontrols
            qmake
          ] ++ [pkgs.git];

          buildPhase = ''
                    source $stdenv/setup
                    runHook preBuild
                    mkdir -p ./lib/qtil
                    cp -r ../qtil/* lib/qtil/
                    qmake PREFIX=$out
                    make
                    runHook postBuild
                    '';             
          installPhase = "make install";

          distPhase = ''
                    mkdir -p $out/share/applications/
                    cat <<EOF
                    [Desktop Entry]
                    Type=Application
                    Name=OpenCollaborationServices
                    NoDisplay=true
                    Exec=$out/bin/ocs-url %u
                    MimeType=x-scheme-handler/ocs;
                    EOF
          '';
        };
  };
}

{
  description =
    "Application to perform the SAML single sing-on and easily retrieve the SVPNCOOKIE needed by openfortivpn.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

  outputs = { nixpkgs, ... }: {
    packages.x86_64-linux.default =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {

        name = "openfortivpn-webview-qt";
        src = pkgs.fetchFromGitHub {
          repo = "openfortivpn-webview";
          owner = "gm-vm";
          rev = "36fd3ea39306152470ab202e9049f282822a0eef";
          hash = "sha256-BM5hurJDPYpbt2WV6C1dldLx2wD9eDZlTK/TeHXpmY0=";
        };

        buildInputs = [ pkgs.qt6.qtbase pkgs.qt6.qtwebengine ];
        nativeBuildInputs = [ pkgs.qt6.wrapQtAppsHook ];
        dontWrapQtApps = true;

        installPhase = ''
          cd openfortivpn-webview-qt
          qmake .
          make
          mkdir -p $out/bin
          mv openfortivpn-webview $out/bin/
        '';
      };
  };
}

# with import <nixpkgs> { };

# stdenv.mkDerivation rec {
#   name = "openfortivpn-webview-qt";
#   src = pkgs.fetchFromGitHub {
#     repo = "openfortivpn-webview";
#     owner = "gm-vm";
#     rev = "36fd3ea39306152470ab202e9049f282822a0eef";
#     hash = "sha256-BM5hurJDPYpbt2WV6C1dldLx2wD9eDZlTK/TeHXpmY0=";
#   };

#   buildInputs = [ pkgs.qt6.qtbase pkgs.qt6.qtwebengine ];
#   nativeBuildInputs = [ pkgs.qt6.wrapQtAppsHook ];
#   dontWrapQtApps = true;

#   installPhase = ''
#     cd openfortivpn-webview-qt
#     qmake .
#     make
#     mkdir -p $out/bin
#     mv openfortivpn-webview $out/bin/
#   '';
# }

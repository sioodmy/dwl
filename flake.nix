{
  description = "flake for my dwl";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation rec {
      pname = "dwl-custom";
      version = "0.1";

      # Set the source to your local dwl directory
      src = ./.;

      nativeBuildInputs = with pkgs; [
        pkg-config
        wayland # Provides the 'wayland-scanner' tool
        wayland-scanner
        libinput
        pixman
        git
      ];
      # Add the necessary build dependencies for dwl
      buildInputs = with pkgs; [
        xwayland
        libxkbcommon
        wayland-protocols
        wlroots
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilwm
        xorg.xcbutilkeysyms
        xorg.xcbutilimage
        xorg.xcbutilcursor
        xorg.xcbutilrenderutil
        xorg.xcbutilerrors
        xorg.xcbutilwm # ✅ for xcb_ewmh.h
      ];

      # The build and installation process
      buildPhase = ''
        make
      '';

      installPhase = ''
        make install PREFIX=$out
      '';
    };
  };
}


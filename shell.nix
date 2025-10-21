{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "DWL Development Shell";
  buildInputs = with pkgs; [
    gnumake
    libinput
    libxkbcommon
    pixman
    pkg-config
    wayland
    wayland-protocols
    wayland-scanner
    wlroots
    xorg.libX11
    xorg.libxcb
    xorg.xcbutilwm
 ];
}

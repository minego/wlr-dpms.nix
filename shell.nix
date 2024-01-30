{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
	name				= "wlr-dpms dev shell";

	nativeBuildInputs = with pkgs; [
		pkg-config
		wayland-scanner
	];

	buildInputs = with pkgs; [
		wayland
		wayland-protocols
		wlroots
	];
}

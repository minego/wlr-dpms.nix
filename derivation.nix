{ lib, pkgs, stdenv, installShellFiles, wayland, conf ? null, ... }:

stdenv.mkDerivation (finalAttrs: {
	pname				= "wlr-dpms";
	version				= "unstable";
	src					= pkgs.fetchgit {
		url				= "https://git.sr.ht/~dsemy/wlr-dpms";
		sha256			= "sha256-VbO+/PEwY4IpsIodeNeJ15u12Gtb+RaIEv72c0Nx8oA=";
	};

	nativeBuildInputs = with pkgs; [
		pkg-config
		wayland-scanner
	];

	buildInputs = with pkgs; [
		wayland
		wayland-protocols
		wlroots
	];

	outputs = [ "out" ];

	makeFlags = [
		"PREFIX=$(out)"
	];

	meta = {
		homepage		= "https://git.sr.ht/~dsemy/wlr-dpms/";
		description		= "Change output power modes in wlroots compositors";
		license			= lib.licenses.mit;

		inherit (wayland.meta) platforms;
		mainProgram		= "wlr-dpms";
	};
})

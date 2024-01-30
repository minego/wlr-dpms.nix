{
	description			= "A flake to build wlr-dpms";

	inputs = {
		nixpkgs.url		= "github:NixOS/nixpkgs/nixos-unstable";

		# Override the systems for the flake, because this only builds on Linux
		systems.url		= "github:nix-systems/default-linux";
		flake-utils.url	= "github:numtide/flake-utils";
		flake-utils.inputs.systems.follows = "systems";
	};

	outputs = { self, nixpkgs, flake-utils, ... }:

	flake-utils.lib.eachDefaultSystem (system:
		let
			pkgs = nixpkgs.legacyPackages.${system};
		in rec {
			packages.wlr-dpms	= pkgs.callPackage ./derivation.nix {};
			packages.default	= packages.wlr-dpms;
			devShells.default	= import ./shell.nix { inherit pkgs; };
		}
	)
	//
	{
		overlays.default		= final: prev: {
			# Add 'wlr-dpms' to nixpkgs
			wlr-dpms			= prev.pkgs.callPackage ./derivation.nix { };
		};
	};
}



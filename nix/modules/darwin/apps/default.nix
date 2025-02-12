{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		snowfallorg.flake
	];
}
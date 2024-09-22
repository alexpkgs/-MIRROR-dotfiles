{ config, pkgs, ... }:

{
  # Basic user information
  home.username = "alexpkgs";
  home.homeDirectory = "/home/alexpkgs";

  # Home Manager version
  home.stateVersion = "24.05"; # Keep this version to avoid breaking changes

  # Enable Home Manager itself
  programs.home-manager.enable = true;

  home.enableNixpkgsReleaseCheck = false;


  # Include configurations from modules
  imports = [
  ./modules/flameshot.nix
  ./modules/alacritty.nix
  ./modules/dunst.nix
  ./modules/rofi/rofi.nix
  ./packages.nix
  ./modules/starship.nix
  ];
}

{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.lua
    pkgs.dunst
    pkgs.rofi
    pkgs.starship
    pkgs.nerd-font-patcher
    pkgs.xwallpaper
    pkgs.vim
    pkgs.fff
    pkgs.emacs
    pkgs.flameshot
    pkgs.tty-clock
   ];
}
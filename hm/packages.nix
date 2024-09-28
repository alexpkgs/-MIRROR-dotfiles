{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.rofi
    pkgs.starship
    pkgs.nerd-font-patcher
    pkgs.vim
    pkgs.fff
    pkgs.emacs
    pkgs.flameshot
    pkgs.tty-clock
   ];
}
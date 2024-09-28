{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.rofi
    pkgs.starship
    pkgs.zoxide
    pkgs.nerd-font-patcher
    pkgs.vim
    pkgs.fff
    pkgs.emacs
    pkgs.flameshot
    pkgs.tty-clock
   ];
}
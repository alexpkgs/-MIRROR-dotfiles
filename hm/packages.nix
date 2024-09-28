{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.rofi
    pkgs.starship
    pkgs.zoxide
    pkgs.nerd-font-patcher
    pkgs.fff
    pkgs.flameshot
    pkgs.tty-clock
   ];
}
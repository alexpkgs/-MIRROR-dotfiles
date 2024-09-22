{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[>](fg:#fffff)";
        error_symbol = "[X ](fg:#fffff)";
        vimcmd_symbol = "[<](fg:#fffff)";
      };
      git_status = {
        ahead = ">>";
        behind = "<";
        diverged = "<>";
        renamed = "";
        deleted = "X";
      };
      git_commit = {
        tag_symbol = " tag ";
      };
      time = {
        disabled = false;
        style = "green";
        format = "($style)";
      };
    };
  };
}


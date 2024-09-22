{ pkgs, ... }: let
  # guh?
in {
  home.packages = [ pkgs.libnotify ];

  services.dunst = {
    enable = true;

    settings = {
      global = {
        frame_color = "#252422";
        font = "CozetteVector 10";
        geometry = "300x5+10+45";
        width = 400;
        separator_height = 5;
        padding = 10;
        horizontal_padding = 24;
        frame_width = 3;
        idle_threshold = 120;
        alignment = "left";
        word_wrap = "yes";
        transparency = 5;
        format = "<b>%s</b>: %b";
        markup = "full";
        min_icon_size = 32;
        max_icon_size = 128;
        shrink = 0;
      };

      urgency_low = {
        background = "#252422";
        foreground = "#685c56";
      };

      urgency_normal = {
        background = "#252422";
        foreground = "#685c56";
      };

      urgency_critical = {
        background = "#252422";
        foreground = "#a8334c";
        frame_color = "#1a1b1c";
      };
    };
  };
}
























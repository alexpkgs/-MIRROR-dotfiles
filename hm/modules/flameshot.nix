{ config, pkgs, ... }:

{
  services.flameshot = {
    enable = true;  # Enable Flameshot
    settings = {
      General = {
        uiColor = "#252422";  
        contrastUiColor = "#ffffff";  
        contrastOpacity = 188;
        saveAsFileExtension = "png";
        savePath = "/home/alexpkgs/Pictures/Screenshots";
        savePathFixed = true;
        saveAfterCopy = true;
        useJpgForClipboard = true;
        startupLaunch = true;
        showStartupLaunchMessage = false;
        showDesktopNotification = false;
        showSidePanelButton = true;
        showHelp = false;
        showMagnifier = true;
        squareMagnifier = false;
      };
    };
  };
}


{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./intel-drivers.nix
    ];

  # Bootloader configuration.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "luv"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # gdm and bspwm.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # keymap for x11 (please don't change)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # sound via pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Flakes and optimise
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  # zsh
  users.defaultUserShell = pkgs.elvish;
  

  # user # don't touch
  users.users.alexpkgs = {
    isNormalUser = true;
    description = "alexpkgs";
    extraGroups = [ "networkmanager" "wheel" ];
    # Add any user-specific packages here if needed.
    packages = with pkgs; [
      # Uncomment to install Thunderbird
      # thunderbird
    ];
  };



  # unfree
  nixpkgs.config.allowUnfree = true;

  # System packages to install.
  environment.systemPackages = with pkgs; [
    cmus
    firefox
    elvish
    wezterm
    awesome
  ];

  # awesome
  services.xserver.windowManager.awesome.enable = true;

  # System state version.
  system.stateVersion = "24.05"; # Did you read the comment?
}


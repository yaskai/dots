# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, callPackage, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  #hardware.opengl = {
  #  enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
  #};

  hardware.graphics.enable = true;

  #services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["amdgpu"];

  #services.xserver.displayManager.lightdm.enable = true;
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.gdm.enable = true; 
  services.displayManager.defaultSession = "hyprland";

  #services.greetd.enable = true;
  #services.xserver.displayManager.lightdm.greeters.tiny.enable = true;

  stylix.enable = true;  
  stylix.autoEnable = true;

  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oceanicnext.yaml";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

  stylix.image = ./Wallpapers/leaves00.png;
  stylix.polarity = "dark";  

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.cursor.size = 24; 
 
  stylix.fonts = {
    monospace = {
      #package = pkgs.dejavu_fonts;
      #name = "DejaVu Sans Mono";
      #package = pkgs.nerdfonts;
      #name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.fantasque-sans-mono;
      name = "Fantasque Sans Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.fonts.sizes.terminal = 15; # Default 12

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-kai"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  programs.xwayland.enable = true;  
  #services.displayManager.sddm.enable = true;

  # Enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # Enable thunar
  programs.thunar.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    #xkbVariant = "";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
	Name = "Hello";
	ControllerMode = "dual";
	FastConnectable = "true";
	Experimental = "true";
      };
      Policy = { AutoEnable = "true"; };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kai = {
    isNormalUser = true;
    description = "Kai Yasko";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  services.displayManager.autoLogin.user = "kai";
  services.displayManager.autoLogin.enable = true;

  # Home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
  };

  #services.geoclue2.enable = true;
  #location.provider = "geoclue2";
  
  #location = {
  #  provider = "manual";
    #latitude = 45.5019;
    #longitude = 73.5674;
  #  latitude = 45.0;
  #  longitude = 73.0;
  #};

  # Redshift
  #services.redshift = {
  #  enable = true;
  #  brightness = {
  #    day = "1";
  #    night = "1";
  #  };
  #  temperature = {
  #    day = 5500;
  #    night = 3700;
  #  };
  #};

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Install steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  
  programs.gamemode.enable = true;

  programs.nix-ld.enable = true;
  #services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    alacritty
    pavucontrol
    blueman
    brightnessctl
    libsixel
    cargo
    #kitty
    #xarchiver
    swaycons
    distrobox
    boxbuddy
    killall
    networkmanagerapplet
    pciutils

    #terminal stuff
    htop
    btop
    sl
    cmatrix
    figlet
    cpufetch
    asciiquarium
    fastfetch
    cowsay
    fortune
    #jrnl
    bunbun
    nim
    gzip
    viu
    yazi

     waybar
    (waybar.overrideAttrs (oldAttrs: {
    	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
   
    dunst
    libnotify
    hyprpaper
    rofi-wayland

    spotify
    spotify-player  

    cinnamon.pix
    celluloid

    #krita
    discord
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
    font-awesome
    ubuntu_font_family
    fantasque-sans-mono
  ];

  # Virtualisation
  #virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

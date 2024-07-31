{ config, pkgs, lib, stylix, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kai";
  home.homeDirectory = "/home/kai";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # pkgs.neovim

    pkgs.cinnamon.nemo-with-extensions
    pkgs.cinnamon.folder-color-switcher
    pkgs.neofetch
    pkgs.cbonsai
    pkgs.nerdfetch
    pkgs.cbonsai
    pkgs.cava
    pkgs.dolphin-emu
    pkgs.maxfetch
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kai/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  services.dunst = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = lib.mkForce 0.7;
      colors.draw_bold_text_with_bright_colors = true;
      mouse.hide_when_typing = true;
    };    
  };


  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
	
      dynamic_background_opcaity = lib.mkForce "no";
      background_opacity = lib.mkForce "0.7";
      background_tint = lib.mkForce "0.0";
      background_tint_gaps = lib.mkForce "0.0";
      dim_opacity = lib.mkForce "0.0";
    };
  };

  programs.foot = {
    enable = true;

    settings = {
      mouse = {
        hide-when-typing = true;
      };
    
      colors = {
        alpha = lib.mkForce "0.7";
      };

    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = false;
    
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      elixir-tools-nvim
      nvchad-ui
      catppuccin-nvim
    ];
  };

  #wayland.windowManager.hyprland.settings.general = {
  #  "col.active_border" = lib.mkForce "rgb${config.lib.stylix.colors.base0E})";
  #};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

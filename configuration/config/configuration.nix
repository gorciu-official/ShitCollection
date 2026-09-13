{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  services.logind.settings.Login.HandlePowerKey = "suspend";

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  networking.hostName = "Gorciu-Computer";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  console.keyMap = "pl2";

  users.users."gorciu" = {
    isNormalUser = true;
    description = "Gorciu";
    # mostly bc nixos is fucked up and does not let me login otherwise
    # ill just set a password on every session ok ? (lol)
    hashedPassword = "";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     # code editors 
     neovim

     # applications 
     firefox 
     satty
     kitty
     vesktop

     # wm look and feel thingies
     waybar
     rofi
     awww
     mako
     kdePackages.breeze
     hyprshot
     hypridle
     hyprlock
     hyprpolkitagent
     pinentry-curses

     # command line tools 
     fastfetch
     wl-clipboard
     cliphist
     unzip
     git
     tmux
     zoxide
     gnupg
     jq

     # coding enviorments (i can't spell this word ok????)
     go
     nodejs_26
     deno
     qemu_full
     gcc
     clang
     clang-tools
     gnumake
     xorriso
     nasm
     gdb
     gef
     cargo
     rustc
     openssl
     mongodb-ce
     emscripten
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
      "/etc/ssh"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager"
    ];
    files = [
      "/etc/machine-id"
    ];
    # TODO: learn home manager or msth
    users.gorciu = {
      directories = [
        ".config/nvim"
	    ".config/hypr"
	    ".config/waybar"
	    ".config/rofi"
	    ".config/mozilla/firefox"
	    ".local/share/vesktop"
	    ".local/share/nvim"
        ".ssh"
        ".gnupg"
        ".config/vesktop/"
	    "pictures/wallpapers"
        "projects"
      ];
      files = [
        ".bashrc"
	    ".bash_history"
        ".gitconfig"
        ".config/user-dirs.dirs"
      ];
    };
  };

  # first version of NixOS on the system  
  system.stateVersion = "26.05"; 
}

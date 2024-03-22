{
  system.defaults.NSGlobalDomain = {
    "com.apple.trackpad.scaling" = 5.0;
    AppleFontSmoothing = 1;
    AppleInterfaceStyle = "Dark";
    AppleInterfaceStyleSwitchesAutomatically = false;
    AppleICUForce24HourTime = true;
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    AppleShowScrollBars = "Automatic";
    AppleTemperatureUnit = "Celsius";
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;
    InitialKeyRepeat = 15;
    KeyRepeat = 2;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    _HIHideMenuBar = false;
  };

  # Firewall
  system.defaults.alf = {
    globalstate = 1;
    allowsignedenabled = 1;
    allowdownloadsignedenabled = 1;
    stealthenabled = 1;
  };

  # Dock and Mission Control
  system.defaults.dock = {
    autohide = true;
    expose-group-by-app = false;
    mru-spaces = false;
    tilesize = 48;
    # Disable all hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  # Dock Apps
  system.defaults.dock.persistent-apps = [
    "/System/Library/CoreServices/Finder.app"
    "/System/Applications/Launchpad.app"
  ];

  # Login and lock screen
  system.defaults.loginwindow = {
    GuestEnabled = false;
    DisableConsoleAccess = true;
  };

  # Spaces
  system.defaults.spaces.spans-displays = false;

  # Trackpad
  system.defaults.trackpad = {
    Clicking = false;
    TrackpadRightClick = true;
  };

  # Finder
  system.defaults.finder = {
    FXEnableExtensionChangeWarning = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    CreateDesktop = false;
    FXDefaultSearchScope = "SCcf";
    FXPreferredViewStyle = "Nlsv";
    ShowPathbar = true;
    ShowStatusBar = true;
    QuitMenuItem = true;
  };

  system.defaults.menuExtraClock.Show24Hour = true;
  system.defaults.menuExtraClock.ShowAMPM = false;

  system.defaults.screencapture.type = "png";
  system.defaults.screencapture.location =
    "/Users/ts/Library/Mobile Documents/com~apple~CloudDocs/Screenshots";

  time.timeZone = "Europe/Berlin";
}

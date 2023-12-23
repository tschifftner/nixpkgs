{ pkgs, lib, ... }:

let
  ambimax = {
    name = "Tobias" + " " + "Schifftner";
    email = "ts" + "@" + "ambimax.de";
  };

in {

  accounts.email.accounts."${ambimax.email}" = {
    thunderbird.enable = true; # Enables this account in Thunderbird
    primary = true;
    flavor = "gmail.com";
    address = ambimax.email;
    userName = ambimax.email;
    realName = ambimax.name; # Your display name
    # storePassword = true;
    passwordCommand = ''
      op item get "s7vnc2psfvl6472v4d5rgbdkza" --fields Password --account my
    '';
    imap = {
      host = "imap.gmail.com";
      port = 993;
      ssl = true;
    };
    smtp = {
      host = "smtp.gmail.com";
      port = lib.mkForce 587;
    };
  };

  #   programs.thunderbird = {
  #     enable = true;
  #     settings = {
  #       "general.useragent.override" = "";
  #       "privacy.donottrackheader.enabled" = true;
  #     };
  #   };
}

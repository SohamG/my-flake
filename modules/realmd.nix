{ config, pkgs, lib, ... }:

with lib;

let
  pkg = pkgs.realmd;
  cfg = myflake.realmd;
in
{
  options.myflake.realmd = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable the realmd service which allows using `realm` to join
        machines to AD/LDAP domains.
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.packages = [ pkgs.realmd ];

  };
}

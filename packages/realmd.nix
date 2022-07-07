{ pkgs, ... }:

pkgs.stdenv.mkDerivation {

  name = "realmd";
  version = "0.16.3";

  src = builtins.fetchTarball {
    url =
      "http://www.freedesktop.org/software/realmd/releases/realmd-0.16.3.tar.gz";
    sha256 = "1zknqm7j3dnwkwrpnshc0ya8z0sc4qjs11qa4qnw84wyhx19fp1g";
  };

  buildInputs = with pkgs; [
    openldap.dev
    libkrb5
    packagekit
    polkit
    libxslt
    intltool
    glib
    pkg-config
    systemd
  ];

  configureFlags = [
    "--with-distro=redhat"
    "--disable-doc"
    "--with-systemd-unit-dir=$out/lib/systemd"
  ];
}

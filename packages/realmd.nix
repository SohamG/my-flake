{ pkgs, lib, ...}:

with pkgs;
with lib;
stdenv.mkDerivation rec {

  name = "realmd";
  version = "0.16.3";

  src = builtins.fetchTarball {
    url =
      "http://www.freedesktop.org/software/realmd/releases/realmd-0.16.3.tar.gz";
    sha256 = "1zknqm7j3dnwkwrpnshc0ya8z0sc4qjs11qa4qnw84wyhx19fp1g";
  };

  buildInputs = [
    openldap
    libkrb5
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
    "--sysconfdir=$out/etc"
    "--without-systemd-unit-dir"
  ];
}

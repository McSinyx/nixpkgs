{ lib, stdenv, fetchFromGitHub, nix-update-script, wrapGAppsHook
, meson, ninja, pkg-config, vala_0_52, python3
, glib, glib-networking, json-glib, libgee, gnome, gtk4, libadwaita, libsecret

}:

stdenv.mkDerivation rec {
  pname = "tootle";
  version = "unstable-2021-09-09";

  src = fetchFromGitHub {
    owner = "bleakgrey";
    repo = pname;
    rev = "02f918d6377f78481de1b9d9485bfb4fa183aaaa";
    sha256 = "sha256-BYi0/oRhO3oytR0q4LAoTlWYtMqstaNSltJs+zJVuBM=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    # Does not build with vala 0.54
    # https://github.com/bleakgrey/tootle/issues/337
    vala_0_52
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    glib-networking
    json-glib
    libgee
    gnome.libsoup
    gtk4
    libadwaita
    libsecret
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  passthru = {
    updateScript = nix-update-script {
      attrPath = pname;
    };
  };

  meta = with lib; {
    description = "GTK-based Mastodon client";
    homepage = "https://apps.gnome.org/app/com.github.bleakgrey.tootle";
    license = licenses.gpl3;
    maintainers = with maintainers; [ dtzWill ];
  };
}

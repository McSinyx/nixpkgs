{ lib, stdenv, fetchFromGitHub, cmake, SDL2, SDL2_image, SDL2_mixer, SDL2_ttf, Cocoa }:

stdenv.mkDerivation rec {
  pname = "flare-engine";
  version = "1.11.104";

  src = fetchFromGitHub {
    owner = "flareteam";
    repo = pname;
    rev = "a8de5d96b344a409815e9e3fc292a6f578149c36";
    sha256 = "08hq99q7k1nl97l76cn31wpi9z62i895p4d1xkqjfmj2mr59j9km";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ SDL2 SDL2_image SDL2_mixer SDL2_ttf ]
    ++ lib.optional stdenv.isDarwin Cocoa;

  meta = with lib; {
    description = "Free/Libre Action Roleplaying Engine";
    homepage = "https://github.com/flareteam/flare-engine";
    maintainers = [ maintainers.aanderse ];
    license = [ licenses.gpl3 ];
    platforms = platforms.unix;
  };
}

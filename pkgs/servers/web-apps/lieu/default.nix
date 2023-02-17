{ lib, buildGoModule, fetchFromGitHub, nixosTests }:

buildGoModule rec {
  pname = "lieu";
  version = "unstable-2022-12-06";

  src = fetchFromGitHub {
    owner = "cblgh";
    repo = pname;
    rev = "22d180233750c59fb3cade40b321c43253eb5b06";
    hash = "sha256-fHWp4NcYE/Qv4hNkvidEBKkpbXhAeNfToNerrpJn1zw=";
  };

  vendorHash = "sha256-OH3C4mL/hPuNI8eSh2wlVkh3UmvlGy1SMztdryQ9rvs=";

  ldflags = [ "-s" "-w" ];

  passthru.tests.lieu = nixosTests.lieu;

  meta = with lib; {
    description = "Community search engine";
    homepage = "https://github.com/cblgh/lieu";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ McSinyx ];
    platforms = platforms.all;
  };
}

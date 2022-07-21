{ lib, fetchFromGitHub, beamPackages }:
beamPackages.mixRelease rec {
  pname = "farside";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "benbusby";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-vSCYrS/PvbcJXRePZgm0XEqq5HdMOVRDjyXxqfnZycg=";
  };

  mixFodDeps = beamPackages.fetchMixDeps {
    pname = "${pname}-deps";
    inherit src version;
    sha256 = "sha256-vq0J0cKd8JOP3Wpp0QZevmqBH4tonq/46zVOLT7JwYY=";
  };

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://farside.link";
    description = "Smart redirecting gateway for various frontend services";
    maintainers = with maintainers; [ McSinyx ];
    platforms = platforms.unix;
  };
}

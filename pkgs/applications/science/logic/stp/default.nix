{ lib, stdenv, cmake, boost, bison, flex, fetchFromGitHub, perl, pkg-config
, python3, python3Packages, zlib, minisat, cryptominisat, gmp }:

stdenv.mkDerivation rec {
  pname = "stp";
  version = "2.3.4";

  src = fetchFromGitHub {
    owner = "stp";
    repo = "stp";
    rev = version;
    sha256 = "sha256-PtONKgqahT9x+5WHi3zyoXwDTdq/VapzBl3Aod7Cbgc=";
  };

  buildInputs = [ boost zlib minisat cryptominisat gmp python3 ];
  nativeBuildInputs = [ cmake bison flex perl pkg-config ];
  preConfigure = ''
    python_install_dir=$out/${python3Packages.python.sitePackages}
    mkdir -p $python_install_dir
    cmakeFlagsArray=(
      $cmakeFlagsArray
      "-DBUILD_SHARED_LIBS=ON"
      "-DPYTHON_LIB_INSTALL_DIR=$python_install_dir"
    )
  '';

  meta = with lib; {
    description = "Simple Theorem Prover";
    maintainers = with maintainers; [ McSinyx ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}

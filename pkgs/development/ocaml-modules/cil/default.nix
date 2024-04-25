{ lib, stdenv, fetchurl, perl, ocaml, findlib, ocamlbuild, num }:

stdenv.mkDerivation rec {
  pname = "ocaml-cil";
  version = "1.7.3";

  src = fetchurl {
    url = "mirror://sourceforge/cil/cil-${version}.tar.gz";
    sha256 = "05739da0b0msx6kmdavr3y2bwi92jbh3szc35d7d8pdisa8g5dv9";
  };
  patches = [ ./link-num.patch ];

  nativeBuildInputs = [ perl ocaml findlib ocamlbuild ];
  propagatedBuildInputs = [ num ];

  strictDeps = true;

  createFindlibDestdir = true;

  preConfigure = ''
    substituteInPlace Makefile.in --replace 'MACHDEPCC=gcc' 'MACHDEPCC=$(CC)'
    export FORCE_PERL_PREFIX=1
  '';
  prefixKey = "-prefix=";

  meta = with lib; {
    homepage = "http://kerneis.github.io/cil/";
    description = "A front-end for the C programming language that facilitates program analysis and transformation";
    license = licenses.bsd3;
    maintainers = [ maintainers.vbgl ];
    platforms = ocaml.meta.platforms or [ ];
  };
}

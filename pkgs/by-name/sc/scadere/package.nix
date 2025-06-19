{
  lib,
  python3Packages,
  fetchPypi,
  help2man,
}:

python3Packages.buildPythonApplication rec {
  pname = "scadere";
  version = "0.1.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-m8aTO+QSR5BvmuAwhiZ28enC4FU8y9TPRJH0KNLUvC0=";
  };

  build-system = [ python3Packages.flit-core ];
  postInstall = ''
    make --directory=doc --jobs=$(nproc) install PREFIX=$out
  '';

  nativeBuildInputs = [ help2man ];
  nativeCheckInputs = with python3Packages; [
    hypothesis pytestCheckHook pytest-asyncio trustme
  ];

  meta = {
    description = "Automatic configuration of connected screens/monitors";
    homepage = "https://trong.loang.net/scadere/about";
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ McSinyx ];
    mainProgram = "scadere-check";
  };
}

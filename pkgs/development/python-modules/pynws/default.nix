{ lib
, aiohttp
, buildPythonPackage
, fetchFromGitHub
, freezegun
, metar
, pytest-aiohttp
, pytest-asyncio
, pytest-cov
, pytestCheckHook
, pythonOlder
, setuptools
, setuptools-scm
, tenacity
}:

buildPythonPackage rec {
  pname = "pynws";
  version = "1.8.0";
  pyproject = true;

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "MatthewFlamm";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-KUCylHYng6mn2TWKf8C7k0IoerM22OIQ7pJMKi5SF3A=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    aiohttp
    metar
  ];

  optional-dependencies.retry = [
    tenacity
  ];

  nativeCheckInputs = [
    freezegun
    pytest-aiohttp
    pytest-asyncio
    pytest-cov
    pytestCheckHook
  ] ++ lib.flatten (lib.attrValues optional-dependencies);

  pythonImportsCheck = [ "pynws" ];

  meta = with lib; {
    description = "Python library to retrieve data from NWS/NOAA";
    homepage = "https://github.com/MatthewFlamm/pynws";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}

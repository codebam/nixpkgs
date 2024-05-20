{ lib
, buildPythonPackage
, fetchFromGitHub

, cryptography
, pyusb
, pyyaml
}:

buildPythonPackage rec {
  pname = "validity";
  version = "2023-05-07";

  src = fetchFromGitHub {
    owner = "uunicorn";
    repo = "python-${pname}";
    rev = "ca21528b27d12dd952e4418c8a9845584f137b57";
    hash = "sha256-gHSfqVts/XSFjRR35GkCQNrsCzclmHHZoQlZPH1XNYo=";
  };

  propagatedBuildInputs = [ cryptography pyusb pyyaml ];

  doCheck = true;

  meta = with lib; {
    description = "Validity fingerprint sensor prototype";
    homepage = "https://github.com/uunicorn/python-validity";
    license = licenses.mit;
  };
}

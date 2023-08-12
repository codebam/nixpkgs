{ lib
, buildPythonPackage
, fetchFromGitHub
, gpytorch
, linear_operator
, multipledispatch
, pyro-ppl
, setuptools
, setuptools-scm
, wheel
, torch
, scipy
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "botorch";
  version = "0.8.5";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-VcNHgfk8OfLJseQxHksycWuCPCudCtOdcRV0XnxHSfU=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
    wheel
  ];

  propagatedBuildInputs = [
    gpytorch
    linear_operator
    multipledispatch
    pyro-ppl
    scipy
    torch
  ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  checkInputs = [
    pytestCheckHook
  ];
  pythonImportsCheck = [ "botorch" ];

  meta = with lib; {
    description = "Bayesian Optimization in PyTorch";
    homepage = "https://botorch.org";
    license = licenses.mit;
    maintainers = with maintainers; [ veprbl ];
  };
}

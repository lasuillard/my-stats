{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  darwin,
}:
let
  version = "0.2.1";

  # NOTE: ARM is not supported by prom-write
  platformMap = {
    "x86_64-linux" = {
      asset = "prom-write-linux-x86";
      sha256 = "sha256-T/CSIpqyfz8+gn3grjhrj+gllRXP1PQxBtAgHmzMsw8="; # Replace with real hash
    };
    "x86_64-darwin" = {
      asset = "prom-write-x86-apple-darwin";
      sha256 = "sha256-ccZvKCGjWxjnnLa7dZIJ16i2qpi4rpCmGTjdYv4ytqE="; # Replace with real hash
    };
  };

  sysAttrs =
    platformMap.${stdenv.hostPlatform.system}
      or (throw "Unsupported architecture: ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "prom-write";
  inherit version;

  src = fetchurl {
    url = "https://github.com/theduke/prom-write/releases/download/v${version}/${sysAttrs.asset}";
    sha256 = sysAttrs.sha256;
  };

  # It's raw binary, no need to unpack
  dontUnpack = true;

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];
  buildInputs =
    lib.optionals stdenv.isLinux [ stdenv.cc.cc.lib ]
    ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

  installPhase = ''
    runHook preInstall

    mkdir --parents "''${out}/bin"
    cp ''${src} "''${out}/bin/prom-write"
    chmod +x "''${out}/bin/prom-write"

    runHook postInstall
  '';

  meta = with lib; {
    description = "CLI and Rust library for sending metrics to Prometheus over the remote write API.";
    homepage = "https://github.com/theduke/prom-write";
    license = with licenses; [
      mit
      asl20
    ]; # Actually, it's dual-licensed under MIT and Apache-2.0
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
    ];
  };
}

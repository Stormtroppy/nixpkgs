{
  lib,
  stdenv,
  libX11,
  libXpm,
  libXext,
  pkg-config,
  fetchurl
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "wmsm-app";
  version = "0.2.1";

  src = fetchurl {
    url = "https://www.dockapps.net/download/wmsm.app-${finalAttrs.version}.tar.bz2";
    hash = "sha256-NpqPLlZzxrerDPhRZvOPv1U92WbDwc/uwOMoN979Msc=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ 
    libX11 
    libXpm 
    libXext 
  ];

  #Settings to fix build errors due to it being legacy code
  NIX_CFLAGS_COMPILE = [
    "-fcommon" 
    "-fgnu89-inline"
    "-I../wmgenral"
  ];

  sourceRoot = "wmsm.app-${finalAttrs.version}/wmsm";

  installPhase = ''
    runHook preInstall
    install -Dm755 wmsm $out/bin/wmsm
    runHook postInstall
  '';

  meta = {
    description = "WindowMaker System Monitor";
    homepage = "https://www.dockapps.net/wmsmapp";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
    maintainers = [ "Stormtroppy" ];
    mainProgram = "wmsm";
  };
})

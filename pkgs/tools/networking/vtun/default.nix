{ stdenv, fetchurl, openssl, lzo, zlib, yacc, flex }:

stdenv.mkDerivation rec {
  name = "vtun-3.0.3";

  src = fetchurl {
    url = "mirror://sourceforge/vtun/${name}.tar.gz";
    sha256 = "1jxrxp3klhc8az54d5qn84cbc0vdafg319jh84dxkrswii7vxp39";
  };

  patchPhase = ''
    sed -i -e 's/-m 755//' -e 's/-o root -g 0//' Makefile.in
    sed -i '/strip/d' Makefile.in
  '';
  buildInputs = [ lzo openssl zlib yacc flex ];

  configureFlags = ''
    --with-lzo-headers=${lzo}/include/lzo
    --with-ssl-headers=${openssl}/include/openssl
    --with-blowfish-headers=${openssl}/include/openssl'';

  meta = with stdenv.lib; {
      description = "Virtual Tunnels over TCP/IP with traffic shaping, compression and encryption";
      homepage = http://vtun.sourceforge.net/;
      license = licenses.gpl2;
      platforms = platforms.linux;
      maintainers = with maintainers; [ pSub ];
  };
}

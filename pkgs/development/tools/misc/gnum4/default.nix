{ lib, stdenv, fetchurl }:

# Note: this package is used for bootstrapping fetchurl, and thus
# cannot use fetchpatch! All mutable patches (generated by GitHub or
# cgit) that are needed here should be included directly in Nixpkgs as
# files.

stdenv.mkDerivation rec {
  pname = "gnum4";
  version = "1.4.19";

  src = fetchurl {
    url = "mirror://gnu/m4/m4-${version}.tar.bz2";
    sha256 = "sha256-swapHA/ZO8QoDPwumMt6s5gf91oYe+oyk4EfRSyJqMg=";
  };

  # https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-devel/m4/m4-1.4.19-r1.ebuild
  patches = lib.optional stdenv.hostPlatform.isLoongArch64 ./loong-fix-build.patch;
  postPatch = if stdenv.hostPlatform.isLoongArch64 then ''
    touch ./aclocal.m4 ./lib/config.hin ./configure ./doc/stamp-vti || die
    find . -name Makefile.in -exec touch {} + || die
  '' else null;

  strictDeps = true;
  enableParallelBuilding = true;

  doCheck = false;

  configureFlags = [ "--with-syscmd-shell=${stdenv.shell}" ]
    ++ lib.optional stdenv.hostPlatform.isMinGW "CFLAGS=-fno-stack-protector";

  meta = {
    description = "GNU M4, a macro processor";
    longDescription = ''
      GNU M4 is an implementation of the traditional Unix macro
      processor.  It is mostly SVR4 compatible although it has some
      extensions (for example, handling more than 9 positional
      parameters to macros).  GNU M4 also has built-in functions for
      including files, running shell commands, doing arithmetic, etc.

      GNU M4 is a macro processor in the sense that it copies its
      input to the output expanding macros as it goes.  Macros are
      either builtin or user-defined and can take any number of
      arguments.  Besides just doing macro expansion, m4 has builtin
      functions for including named files, running UNIX commands,
      doing integer arithmetic, manipulating text in various ways,
      recursion etc...  m4 can be used either as a front-end to a
      compiler or as a macro processor in its own right.
    '';
    homepage = "https://www.gnu.org/software/m4/";

    license = lib.licenses.gpl3Plus;
    mainProgram = "m4";
    platforms = lib.platforms.unix ++ lib.platforms.windows;
  };

}

export SRCDIR=`pwd` &&

cd unix &&

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit) &&
make &&

sed -e "s#$SRCDIR/unix#/usr/lib#" \
    -e "s#$SRCDIR#/usr/include#"  \
    -i tclConfig.sh               &&

sed -e "s#$SRCDIR/unix/pkgs/tdbc1.1.0#/usr/lib/tdbc1.1.0#" \
    -e "s#$SRCDIR/pkgs/tdbc1.1.0/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/tdbc1.1.0/library#/usr/lib/tcl8.6#" \
    -e "s#$SRCDIR/pkgs/tdbc1.1.0#/usr/include#"            \
    -i pkgs/tdbc1.1.0/tdbcConfig.sh                        &&

sed -e "s#$SRCDIR/unix/pkgs/itcl4.1.2#/usr/lib/itcl4.1.2#" \
    -e "s#$SRCDIR/pkgs/itcl4.1.2/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/itcl4.1.2#/usr/include#"            \
    -i pkgs/itcl4.1.2/itclConfig.sh                        &&

unset SRCDIR

make install &&
make install-private-headers &&
ln -v -sf tclsh8.6 /usr/bin/tclsh &&
chmod -v 755 /usr/lib/libtcl8.6.so

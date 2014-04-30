OUTPATH=/var/www/mozilla.cat/pootle/mozilla/an/xpi

CC=gcc-4.7
CXX=g++-4.7

VERSION=beta
DATE=`date +%Y%m%d-%H%M`

# Obte les traduccions actuals de Mozilla
#-----------------------------------------
cd mozilla-$VERSION
hg pull -u
hg update --clean
cd ..


cd l10n/an
#hg pull -u
cd ../..


# Fa copia de seguretat i ho borra tot
#-----------------------------------------
rm -rf l10n/en-US
rm -rf po/an

# Crea estructura  l10n/en-US
#----------------------------------------
get_moz_enUS.py -s mozilla-$VERSION -d l10n -p browser
get_moz_enUS.py -s mozilla-$VERSION -d l10n -p mobile

# Crea fitxers PO catalans  a po/an
#-----------------------------------------
#moz2po -t l10n/en-US -i l10n/an -o po/an

#rm -rf l10n/an
#po2moz -t l10n/en-US -i po/an -o l10n/an

cp -f po/mozilla/mozconfig-aragon-firefox mozilla-$VERSION/.mozconfig

base=`pwd` 

cd mozilla-$VERSION
rm -rf aragon
make -f client.mk configure
cd aragon
cd config
make
cd ../browser/locales
make langpack-an

cd $base
LASTFFXPI=`ls -lrt mozilla-$VERSION/aragon/dist/linux-x86_64/xpi | awk '{ f=$NF }; END{ print f }'`
LASTFFXPIOUT=$LASTFFXPI.$DATE.xpi
perl po/modifyMaxMin.pl mozilla-$VERSION/aragon/dist/linux-x86_64/xpi/$LASTFFXPI
cd mozilla-$VERSION/aragon/dist/linux-x86_64/xpi
rm -rf tmp
mkdir tmp
cp $LASTFFXPI tmp
cd tmp
unzip $LASTFFXPI
find . -name ".mkdir.done" | xargs rm
rm -rf browser/crashreporter-override.ini
rm -rf browser/defaults
rm -rf browser/searchplugins
rm $LASTFFXPI
zip -r $LASTFFXPI chrome.manifest install.rdf browser chrome
cp $LASTFFXPI $OUTPATH/$LASTFFXPIOUT


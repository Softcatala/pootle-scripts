OUTPATH=/var/www/mozilla.cat/pootle/mozilla/ca-valencia/xpi

OBJFF=/home/pootle/hg/beta/mozobj/firefox-valencia
rm -rf $OBJFF
mkdir -p $OBJFF

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

cd comm-$VERSION
hg pull -u
hg update --clean
python client.py checkout
cd ..

cd l10n/ca
hg pull -u
cd ../..


# Fa copia de seguretat i ho borra tot
#-----------------------------------------
rm -rf l10n/en-US
rm -rf po/ca

# Crea estructura  l10n/en-US
#----------------------------------------
get_moz_enUS.py -s mozilla-$VERSION -d l10n -p browser
get_moz_enUS.py -s comm-$VERSION -d l10n -p mail
get_moz_enUS.py -s comm-$VERSION -d l10n -p calendar
#Patch irc
mkdir -p l10n/en-US/extensions/irc
cp -rf comm-$VERSION/mozilla/extensions/irc/locales/en-US/* l10n/en-US/extensions/irc

# Crea fitxers PO catalans  a po/ca
#-----------------------------------------
moz2po -t l10n/en-US -i l10n/ca -o po/ca

# Update SVN
cd po
svn up

#Copy ca-valencia
rm -rf ca-valencia
cp -rf ca ca-valencia

./recorre_les_fonts-moz ca-valencia

cd ..

rm -rf l10n/ca-valencia
po2moz -t l10n/en-US -i po/ca-valencia -o l10n/ca-valencia

cp -rf l10n/ca/browser/searchplugins/* l10n/ca-valencia/browser/searchplugins
cp -rf l10n/ca/mail/searchplugins/* l10n/ca-valencia/mail/searchplugins

#Process files
perl po/processMozFile.pl l10n/ca-valencia/browser/chrome/browser/browser.dtd dtd savePageCmd.accesskey2 "d"
perl po/processMozFile.pl l10n/ca-valencia/toolkit/chrome/global/intl.properties props general.useragent.locale "ca-valencia"
perl po/processMozFile.pl l10n/ca-valencia/toolkit/chrome/global/intl.properties props intl.accept_languages "ca-valencia, ca, en-us, en"
perl po/processMozFile.pl l10n/ca-valencia/toolkit/defines.inc define MOZ_LANG_TITLE "Català (valencià)"

cp -f po/mozilla/mozconfig-firefox mozilla-$VERSION/.mozconfig
cp -f po/mozilla/mozconfig-thunderbird comm-$VERSION/.mozconfig

base=`pwd` 

cd $OBJFF
make -f ../../mozilla-$VERSION/client.mk configure
cd config
make
cd ../browser/locales
make merge-ca-valencia LOCALE_MERGEDIR=./mergedir
make langpack-ca-valencia LOCALE_MERGEDIR=./mergedir

cd $base
LASTFFXPI=`ls -lrt $OBJFF/dist/linux-x86_64/xpi | awk '{ f=$NF }; END{ print f }'`
LASTFFXPIOUT=$LASTFFXPI.$DATE.xpi
perl po/modifyMaxMin.pl $OBJFF/dist/linux-x86_64/xpi/$LASTFFXPI
cd $OBJFF/dist/linux-x86_64/xpi
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

cd $base
cd comm-$VERSION
rm -rf valencia
# Start hack (sic)
cd mozilla
ln -s ../valencia .
cd ..
# End Hack (sic)
make -f client.mk configure
cd valencia
cd config
make
cd ../mail/locales
make merge-ca-valencia LOCALE_MERGEDIR=./mergedir
make langpack-ca-valencia LOCALE_MERGEDIR=./mergedir

cd $base
LASTTBXPI=`ls -lrt comm-$VERSION/valencia/dist/linux-x86_64/xpi | awk '{ f=$NF }; END{ print f }'`
LASTTBXPIOUT=$LASTTBXPI.$DATE.xpi
perl po/modifyMaxMin.pl comm-$VERSION/valencia/dist/linux-x86_64/xpi/$LASTTBXPI
cd comm-$VERSION/valencia/dist/linux-x86_64/xpi
rm -rf tmp
mkdir tmp
cp $LASTTBXPI tmp
cd tmp
unzip $LASTTBXPI
find . -name ".mkdir.done" | xargs rm
rm -rf mail/crashreporter-override.ini
rm -rf mail/defaults
rm -rf mail/searchplugins
rm $LASTTBXPI
zip -r $LASTTBXPI chrome.manifest install.rdf mail chrome
cp $LASTTBXPI $OUTPATH/$LASTTBXPIOUT




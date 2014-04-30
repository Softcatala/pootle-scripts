export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

# Obte les traduccions actuals de Mozilla
#-----------------------------------------
cd aurora-src
hg pull -u
hg update --clean
cd ..

cd comm-aurora
hg pull -u
hg update --clean
python client.py checkout
cd ..

# Fa copia de seguretat i ho borra tot
#-----------------------------------------
rm -rf l10n/en-US
rm -rf po/pot

# Crea estructura  l10n/en-US
#----------------------------------------
get_moz_enUS.py -s aurora-src -d l10n -p browser
get_moz_enUS.py -s aurora-src -d l10n -p mobile
get_moz_enUS.py -s comm-aurora -d l10n -p mail
get_moz_enUS.py -s comm-aurora -d l10n -p suite
get_moz_enUS.py -s comm-aurora -d l10n -p calendar

# Crea fitxer POT a po/pot  (PO nous)
#----------------------------------------
mkdir po/pot
moz2po -P -t l10n/en-US -i l10n/en-US -o po/pot
find po/pot -name "*.pot" -exec rename "s/\.pot/\.po/" {} \;


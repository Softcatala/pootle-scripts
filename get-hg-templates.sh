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

# Esborra previ
#-----------------------------------------
rm -rf po/templates
rm -rf l10n/en-US

# Crea estructura  l10n/en-US
#----------------------------------------
get_moz_enUS.py -s aurora-src -d l10n -p browser
get_moz_enUS.py -s aurora-src -d l10n -p mobile
get_moz_enUS.py -s comm-aurora -d l10n -p mail
get_moz_enUS.py -s comm-aurora -d l10n -p suite
get_moz_enUS.py -s comm-aurora -d l10n -p calendar


# Crea fitxers PO de llengues
#-----------------------------------------
moz2po -i l10n/en-US -P -o po/templates

# Carrega els PO al pootle
#---------------------------------------
rm -fr $PODIR/mozilla/templates
cp -r po/templates $PODIR/mozilla/
pootle update_stores --project=mozilla --language=templates
pootle refresh_stats --project=mozilla --language=templates
# Actualitza ca i an
pootle update_against_templates --directory=mozilla/ca
pootle update_against_templates --directory=mozilla/an

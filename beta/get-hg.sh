cd /var/lib/pootle/hg/beta

# Obte les traduccions actuals de Mozilla
#-----------------------------------------
cd mozilla-beta
hg pull -u
hg update --clean
cd ..

cd comm-beta
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
get_moz_enUS.py -s mozilla-beta -d l10n -p browser
get_moz_enUS.py -s mozilla-beta -d l10n -p mobile
get_moz_enUS.py -s comm-beta -d l10n -p mail
get_moz_enUS.py -s comm-beta -d l10n -p suite
get_moz_enUS.py -s comm-beta -d l10n -p calendar


# Crea fitxer POT a po/pot  (PO nous)
#----------------------------------------
mkdir po/pot
moz2po -P -t l10n/en-US -i l10n/en-US -o po/pot
find po/pot -name "*.pot" -exec rename "s/\.pot/\.po/" {} \;



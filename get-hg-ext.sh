cd /var/lib/pootle/hg/

# Obte les traduccions actuals de Mozilla
#-----------------------------------------
cd aurora-src
hg pull -u
cd ..

cd comm-aurora
python client.py checkout
cd ..

cd l10n/es-ES
hg pull -u
cd ../..
cd l10n/fr
hg pull -u
cd ../..
cd l10n/it
hg pull -u
cd ../..

# Fa copia de seguretat i ho borra tot
#-----------------------------------------
rm -rf l10n/en-US
rm -rf po/es-ES
rm -rf po/fr
rm -rf po/it
#rm -rf po/pot

# Crea estructura  l10n/en-US
#----------------------------------------
get_moz_enUS.py -s aurora-src -d l10n -p browser
get_moz_enUS.py -s aurora-src -d l10n -p mobile
get_moz_enUS.py -s comm-aurora -d l10n -p mail
get_moz_enUS.py -s comm-aurora -d l10n -p suite
get_moz_enUS.py -s comm-aurora -d l10n -p calendar


# Crea fitxers PO de llengues
#-----------------------------------------
moz2po -t l10n/en-US -i l10n/es-ES -o po/es-ES
moz2po -t l10n/en-US -i l10n/fr -o po/fr
moz2po -t l10n/en-US -i l10n/it -o po/it

#Crea Pots
#-----------------------------------------
#moz2po -P -t l10n/en-US -i l10n/en-US -o po/pot
#find po/pot -name "*.pot" -exec rename "s/\.pot/\.po/" {} \;

# Carrega els PO al pootle
#---------------------------------------
rm -fr /var/lib/pootle/Pootle/po/mozilla/es-ES
cp -r po/es-ES /var/lib/pootle/Pootle/po/mozilla/
../Pootle/manage.py update_stores --project=mozilla --language=es-ES
../Pootle/manage.py refresh_stats --project=mozilla --language=es-ES

rm -fr /var/lib/pootle/Pootle/po/mozilla/fr
cp -r po/fr /var/lib/pootle/Pootle/po/mozilla/
../Pootle/manage.py update_stores --project=mozilla --language=fr
../Pootle/manage.py refresh_stats --project=mozilla --language=fr

rm -fr /var/lib/pootle/Pootle/po/mozilla/it
cp -r po/it /var/lib/pootle/Pootle/po/mozilla/
../Pootle/manage.py update_stores --project=mozilla --language=it
../Pootle/manage.py refresh_stats --project=mozilla --language=it



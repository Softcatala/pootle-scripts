cd /var/lib/pootle/hg/


# Fa copia de seguretat i ho borra tot
#-----------------------------------------
rm -rf po-gaia/es-ES
rm -rf po-gaia/fr
rm -rf po-gaia/it
#rm -rf po/pot

# Crea estructura  l10n/en-US
#----------------------------------------
cd l10n-gaia/en-US
hg pull -u; hg update --clean
cd ../..

cd l10n-gaia/es
hg pull -u; hg update --clean
cd ../..

cd l10n-gaia/fr
hg pull -u; hg update --clean
cd ../..

cd l10n-gaia/it
hg pull -u; hg update --clean
cd ../..

# Crea fitxers PO de llengues
#-----------------------------------------
moz2po -t l10n-gaia/en-US -i l10n-gaia/es -o po-gaia/es
moz2po -t l10n-gaia/en-US -i l10n-gaia/fr -o po-gaia/fr
moz2po -t l10n-gaia/en-US -i l10n-gaia/it -o po-gaia/it

#Crea Pots
#-----------------------------------------
#moz2po -P -t l10n/en-US -i l10n/en-US -o po/pot
#find po/pot -name "*.pot" -exec rename "s/\.pot/\.po/" {} \;

# Carrega els PO al pootle
#---------------------------------------
rm -fr /var/lib/pootle/Pootle/po/gaia/es
cp -r po-gaia/es /var/lib/pootle/Pootle/po/gaia/
../Pootle/manage.py update_stores --project=gaia --language=es
../Pootle/manage.py refresh_stats --project=gaia --language=es

rm -fr /var/lib/pootle/Pootle/po/gaia/fr
cp -r po-gaia/fr /var/lib/pootle/Pootle/po/gaia/
../Pootle/manage.py update_stores --project=gaia --language=fr
../Pootle/manage.py refresh_stats --project=gaia --language=fr

rm -fr /var/lib/pootle/Pootle/po/gaia/it
cp -r po-gaia/it /var/lib/pootle/Pootle/po/gaia/
../Pootle/manage.py update_stores --project=gaia --language=it
../Pootle/manage.py refresh_stats --project=gaia --language=it


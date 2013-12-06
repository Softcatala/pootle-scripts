cd /var/lib/pootle/hg/


# Fa copia de seguretat i ho borra tot
#-----------------------------------------
rm -rf po-gaia/templates

# Crea estructura  l10n/en-US
#----------------------------------------
cd l10n-gaia/en-US
hg pull -u; hg update --clean
cd ../..

# Crea fitxers PO de llengues
#-----------------------------------------
moz2po -i l10n-gaia/en-US -P -o po-gaia/templates


# Carrega els PO al pootle
#---------------------------------------
rm -fr /var/lib/pootle/Pootle/po/gaia/templates
cp -r po-gaia/templates /var/lib/pootle/Pootle/po/gaia/
../Pootle/manage.py update_stores --project=gaia --language=templates
../Pootle/manage.py refresh_stats --project=gaia --language=templates

../Pootle/manage.py update_from_templates --directory=gaia/ca


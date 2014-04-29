export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

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
rm -fr $PODIR/gaia/templates
cp -r po-gaia/templates $PODIR/gaia/
pootle update_stores --project=gaia --language=templates
pootle refresh_stats --project=gaia --language=templates
pootle update_from_templates --directory=gaia/ca


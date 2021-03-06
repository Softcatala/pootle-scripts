export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

# Genera els fitxers PO a pootle/po
#-----------------------------------
rm -rf $PODIR/gaia/ca/.translation_index
pootle refresh_stats --project=gaia --language=ca
pootle sync_stores --project=gaia --language=ca

# Copia de seguretat
#----------------------------------
rm -rf l10n-gaia/cabak
rm -rf l10n-gaia/ca-out.tgz
rm -rf l10n-gaia/ca-po-out.tgz
cp -R l10n-gaia/ca l10n-gaia/cabak

# Genera els fitxers properties i dtda l10n/ca
#-----------------------------------
po2moz -t l10n-gaia/en-US -i $PODIR/gaia/ca/ -o l10n-gaia/ca

# El resultat el deixa a l10n/out.tgz
#-------------------------------------
tar -cvzf l10n-gaia/ca-out.tgz  --exclude=.hg --exclude=.hgtags l10n-gaia/ca
tar -cvzf l10n-gaia/ca-po-out.tgz --exclude=.translation_index $PODIR/gaia/ca



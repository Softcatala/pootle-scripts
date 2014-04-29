export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

# Genera els fitxers PO a pootle/po
#-----------------------------------
rm -rf $PODIR/mozilla/an/.translation_index
pootle refresh_stats --project=mozilla --language=an
pootle sync_stores --project=mozilla --language=an

# Copia de seguretat
#----------------------------------
rm -rf l10n/anbak
rm -rf l10n/an-out.tgz
rm -rf l10n/an-po-out.tgz
cp -R l10n/an l10n/anbak

# Genera els fitxers properties i dtda l10n/an
#-----------------------------------
rm -rf l10n/an
po2moz -t l10n/en-US -i $PODIR/mozilla/an/ -o l10n/an

# El resultat el deixa a l10n/out.tgz
#-------------------------------------
tar -cvzf l10n/an-out.tgz  --exclude=.hg --exclude=searchplugins --exclude=.hgtags  --exclude=region.properties  l10n/an
tar -cvzf l10n/an-po-out.tgz --exclude=.translation_index $PODIR/mozilla/an

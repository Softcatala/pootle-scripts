cd /var/lib/pootle/hg

# Genera els fitxers PO a pootle/po
#-----------------------------------
rm -rf ../Pootle/po/mozilla/ca/.translation_index
../Pootle/manage.py refresh_stats --project=mozilla --language=ca
../Pootle/manage.py sync_stores --project=mozilla --language=ca

# Copia de seguretat
#----------------------------------
rm -rf l10n/cabak
rm -rf l10n/ca-out.tgz
rm -rf l10n/ca-po-out.tgz
cp -R l10n/ca l10n/cabak

# Genera els fitxers properties i dtda l10n/ca
#-----------------------------------
rm -rf l10n/ca
po2moz -t l10n/en-US -i ../Pootle/po/mozilla/ca/ -o l10n/ca

# El resultat el deixa a l10n/out.tgz
#-------------------------------------
tar -cvzf l10n/ca-out.tgz  --exclude=.hg --exclude=searchplugins --exclude=.hgtags  --exclude=region.properties  l10n/ca
tar -cvzf l10n/ca-po-out.tgz --exclude=.translation_index ../Pootle/po/mozilla/ca



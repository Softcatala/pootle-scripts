cd /var/lib/pootle/hg

# Genera els fitxers PO a pootle/po
#-----------------------------------
rm -rf ../Pootle/po/mozilla/an/.translation_index
../Pootle/manage.py refresh_stats --project=mozilla --language=an
../Pootle/manage.py sync_stores --project=mozilla --language=an

# Copia de seguretat
#----------------------------------
rm -rf l10n/anbak
rm -rf l10n/an-out.tgz
rm -rf l10n/an-po-out.tgz
cp -R l10n/an l10n/anbak

# Genera els fitxers properties i dtda l10n/an
#-----------------------------------
rm -rf l10n/an
po2moz -t l10n/en-US -i ../Pootle/po/mozilla/an/ -o l10n/an

# El resultat el deixa a l10n/out.tgz
#-------------------------------------
tar -cvzf l10n/an-out.tgz  --exclude=.hg --exclude=searchplugins --exclude=.hgtags  --exclude=region.properties  l10n/an
tar -cvzf l10n/an-po-out.tgz --exclude=.translation_index ../Pootle/po/mozilla/an

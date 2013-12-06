cd /var/lib/pootle/hg

# Genera els fitxers PO a pootle/po
#-----------------------------------
../Pootle/manage.py refresh_stats --project=chatzilla --language=ca
../Pootle/manage.py sync_stores --project=chatzilla --language=ca

# Cp PO
cd chatzilla/po
rm -rf ca
rm -rf ca-valencia
cp -rf ../../../Pootle/po/chatzilla/ca .
cp -rf ca ca-valencia
sh ./recorre_les_fonts-moz ca-valencia
cd ..
rm -rf ca
rm -rf ca-valencia
po2moz -t en-US -i po/ca -o ca
po2moz -t en-US -i po/ca-valencia -o ca-valencia

tar -cvzf ca-out.tgz  --exclude=.hg  --exclude=.hgtags   ca ca-valencia
tar -cvzf ca-po-out.tgz --exclude=.translation_index po/ca po/ca-valencia



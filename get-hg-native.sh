#Copia els fitxers PO natius aquí
#per ca i an

rm -rf po/ca
rm -rf po/ca.new

cp -r /var/lib/pootle/Pootle/po/mozilla/ca po/ca

pomerge -t po/pot -i po/ca -o po/ca.new

rsync -r --ignore-existing  po/pot/* po/ca.new/

rm -fr /var/lib/pootle/Pootle/po/mozilla/ca

cp -r po/ca.new /var/lib/pootle/Pootle/po/mozilla/ca

../Pootle/manage.py update_stores --project=mozilla --language=ca
../Pootle/manage.py refresh_stats --project=mozilla --language=ca


rm -rf po/an
rm -rf po/an.new

cp -r /var/lib/pootle/Pootle/po/mozilla/an po/an

pomerge -t po/pot -i po/an -o po/an.new

rsync -r --ignore-existing  po/pot/* po/an.new/

rm -fr /var/lib/pootle/Pootle/po/mozilla/an

cp -r po/an.new /var/lib/pootle/Pootle/po/mozilla/an

../Pootle/manage.py update_stores --project=mozilla --language=an
../Pootle/manage.py refresh_stats --project=mozilla --language=an


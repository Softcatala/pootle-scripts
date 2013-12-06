#Copia els fitxers PO natius aquí
#per oc i an

rm -rf po/an
rm -rf po/an.new

cp -r /var/lib/pootle/Pootle/po/mozilla/an po/an

pomerge -t po/pot -i po/an -o po/an.new

rsync -r --ignore-existing  po/pot/* po/an.new/

rm -fr /var/lib/pootle/Pootle/po/mozilla/an

cp -r po/an.new /var/lib/pootle/Pootle/po/mozilla/an

../../Pootle/manage.py update_stores --project=mozilla --language=an
../../Pootle/manage.py refresh_stats --project=mozilla --language=an


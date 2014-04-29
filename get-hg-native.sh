export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

#Copia els fitxers PO natius aquí
#per ca i an

rm -rf po/ca
rm -rf po/ca.new

cp -r $PODIR/mozilla/ca po/ca

pomerge -t po/pot -i po/ca -o po/ca.new

rsync -r --ignore-existing  po/pot/* po/ca.new/

rm -fr $PODIR/mozilla/ca

cp -r po/ca.new $PODIR/mozilla/ca

pootle update_stores --project=mozilla --language=ca
pootle refresh_stats --project=mozilla --language=ca


rm -rf po/an
rm -rf po/an.new

cp -r $PODIR/mozilla/an po/an

pomerge -t po/pot -i po/an -o po/an.new

rsync -r --ignore-existing  po/pot/* po/an.new/

rm -fr $PODIR/mozilla/an

cp -r po/an.new $PODIR/mozilla/an

pootle update_stores --project=mozilla --language=an
pootle refresh_stats --project=mozilla --language=an


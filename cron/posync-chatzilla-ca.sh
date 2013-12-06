#!/bin/sh

BACKUPDIR=/var/www/mozilla.cat/pootle/chatzilla/ca
HGDIR=/var/lib/pootle/hg

cd $HGDIR

DATE=`date +%Y%m%d-%H%M`
sh send-chatzilla.sh
cp chatzilla/ca-out.tgz $BACKUPDIR/strings/ca-$DATE.tgz
cp chatzilla/ca-po-out.tgz $BACKUPDIR/po/ca-po-$DATE.tgz

compare-dirs chatzilla/en-US chatzilla/ca > $BACKUPDIR/strings/ca-$DATE.txt


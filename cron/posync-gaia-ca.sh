#!/bin/sh

BACKUPDIR=/var/www/mozilla.cat/pootle/gaia/ca
PODIR=/var/lib/pootle/Pootle/po/gaia/ca
POOTLEDIR=/var/lib/pootle/Pootle/
HGDIR=/var/lib/pootle/hg

cd $HGDIR

DATE=`date +%Y%m%d-%H%M`
sh send-hg-gaia-ca.sh
cp l10n-gaia/ca-out.tgz $BACKUPDIR/strings/ca-$DATE.tgz
cp l10n-gaia/ca-po-out.tgz $BACKUPDIR/po/ca-po-$DATE.tgz

compare-dirs l10n-gaia/en-US l10n-gaia/ca > $BACKUPDIR/strings/ca-$DATE.log


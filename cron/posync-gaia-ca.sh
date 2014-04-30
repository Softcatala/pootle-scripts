#!/bin/sh

BACKUPDIR=/var/www/mozilla.cat/pootle/gaia/ca
export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

DATE=`date +%Y%m%d-%H%M`
sh send-hg-gaia-ca.sh
cp l10n-gaia/ca-out.tgz $BACKUPDIR/strings/ca-$DATE.tgz
cp l10n-gaia/ca-po-out.tgz $BACKUPDIR/po/ca-po-$DATE.tgz

compare-dirs l10n-gaia/en-US l10n-gaia/ca > $BACKUPDIR/strings/ca-$DATE.log


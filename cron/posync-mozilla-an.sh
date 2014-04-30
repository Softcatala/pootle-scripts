#!/bin/sh

BACKUPDIR=/var/www/mozilla.cat/pootle/gaia/ca
export ENVDIR=/home/pootle/env
export HGDIR=/home/pootle/hg
export PODIR=/home/pootle/po 

source $ENVDIR/bin/activate

cd $HGDIR

DATE=`date +%Y%m%d-%H%M`
sh send-hg-an.sh > $BACKUPDIR/process.txt 2> $BACKUPDIR/error.txt
cp l10n/an-out.tgz $BACKUPDIR/strings/an-$DATE.tgz
cp l10n/an-po-out.tgz $BACKUPDIR/po/an-po-$DATE.tgz

compare-locales aurora-src/browser/locales/l10n.ini l10n/ an > $BACKUPDIR/strings/an-$DATE.txt
compare-locales aurora-src/mobile/locales/l10n.ini l10n/ an >> $BACKUPDIR/strings/an-$DATE.txt


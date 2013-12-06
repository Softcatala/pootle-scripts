#!/bin/sh

BACKUPDIR=/var/www/mozilla.cat/pootle/mozilla/an
PODIR=/var/lib/pootle/Pootle/po/mozilla/an
POOTLEDIR=/var/lib/pootle/Pootle/
HGDIR=/var/lib/pootle/hg

cd $HGDIR

DATE=`date +%Y%m%d-%H%M`
sh send-hg-an.sh > $BACKUPDIR/process.txt 2> $BACKUPDIR/error.txt
cp l10n/an-out.tgz $BACKUPDIR/strings/an-$DATE.tgz
cp l10n/an-po-out.tgz $BACKUPDIR/po/an-po-$DATE.tgz

compare-locales aurora-src/browser/locales/l10n.ini l10n/ an > $BACKUPDIR/strings/an-$DATE.txt
compare-locales aurora-src/mobile/locales/l10n.ini l10n/ an >> $BACKUPDIR/strings/an-$DATE.txt


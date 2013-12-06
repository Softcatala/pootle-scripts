#!/bin/sh

BACKUPDIR=/var/www/mozilla.cat/pootle/mozilla/ca
BACKUPDIRGAIA=/var/www/mozilla.cat/pootle/gaia/ca
HGDIR=/var/lib/pootle/hg

cd $HGDIR

DATE=`date +%Y%m%d-%H%M`
sh send-hg-ca.sh > $BACKUPDIR/process.txt 2> $BACKUPDIR/error.txt
sh send-hg-gaia-ca.sh > $BACKUPDIRGAIA/process.txt 2> $BACKUPDIRGAIA/error.txt
cp l10n/ca-out.tgz $BACKUPDIR/strings/ca-$DATE.tgz
cp l10n/ca-po-out.tgz $BACKUPDIR/po/ca-po-$DATE.tgz
cp l10n-gaia/ca-out.tgz $BACKUPDIRGAIA/strings/ca-$DATE.tgz
cp l10n-gaia/ca-po-out.tgz $BACKUPDIRGAIA/po/ca-po-$DATE.tgz
compare-locales aurora-src/browser/locales/l10n.ini l10n/ ca > $BACKUPDIR/strings/ca-$DATE.txt
compare-locales aurora-src/mobile/locales/l10n.ini l10n/ ca >> $BACKUPDIR/strings/ca-$DATE.txt
compare-locales comm-aurora/mail/locales/l10n.ini l10n/ ca >> $BACKUPDIR/strings/ca-$DATE.txt
compare-locales comm-aurora/suite/locales/l10n.ini l10n/ ca >> $BACKUPDIR/strings/ca-$DATE.txt
compare-locales comm-aurora/calendar/locales/l10n.ini l10n/ ca >> $BACKUPDIR/strings/ca-$DATE.txt
compare-dirs l10n-gaia/en-US l10n-gaia/ca > $BACKUPDIRGAIA/strings/ca-$DATE.txt


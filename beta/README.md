Scripts per a generar paquets d'idioma del Firefox i del Thunderbird a partir de les branques beta de Mozilla.

* update-beta.sh - Genera paquets valencians
* update-an-beta.sh - Genera paquets aragonesos

El directori mozilla conté els fitxers .mozconfig segons els programa

Cal tenir translate-tookit: pip install translate-toolkit

i l'script get_moz_enUS.py:

https://github.com/translate/translate/blob/master/tools/mozilla/get_moz_enUS.py

Per tal de funcionar calen els directoris:

* mozilla-beta: amb codi arrel de la branca beta - https://hg.mozilla.org/releases/mozilla-beta/
* comm-beta: amb codi arrel de branca beta - https://hg.mozilla.org/releases/comm-beta/
* l10n
  * ca: http://hg.mozilla.org/releases/l10n/mozilla-beta/ca/
  * en-US: generat per l'script
  * ca-valencia: generat per l'script

Cal tenir en el directori po que es genera els fitxers:
* processMozFile.pl
* modifyMaxMin.pl

i els fitxers del repositori: https://github.com/Softcatala/adaptadorvariants/tree/master/tools/mozilla

* recorre_les_fonts-moz
* src2valencia-moz.sed



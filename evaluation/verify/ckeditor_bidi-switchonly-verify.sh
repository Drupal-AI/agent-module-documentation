#!/usr/bin/env bash
# Execution VERIFY: PASS when switch_only is TRUE for the BiDi plugin on ckeditor_bidi_h2.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $ed = Editor::load("ckeditor_bidi_h2");
  $v = $ed ? ($ed->getSettings()["plugins"]["ckeditor_bidi_ckeditor5"]["switch_only"] ?? NULL) : NULL;
  print (($v === TRUE) ? "PASS" : "FAIL") . " switch_only=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

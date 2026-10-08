#!/usr/bin/env bash
# Execution VERIFY: PASS when Pagerer's URL querystring override is enabled AND page numbering
# is one-based (index_base=1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("pagerer.settings");
  $ov = $c->get("url_querystring.core_override");
  $ib = $c->get("url_querystring.index_base");
  $ok = (($ov === TRUE || $ov === 1 || $ov === "1") && ((int) $ib === 1));
  print ((($ok) ? "PASS" : "FAIL")." core_override=".var_export($ov,true)." index_base=".var_export($ib,true)."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when tagclouds.settings has levels==12 AND sort_order=='count,desc'.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("tagclouds.settings");
  $lv=$c->get("levels"); $so=$c->get("sort_order");
  $ok=((int)$lv===12 && $so==="count,desc");
  print ($ok?"PASS":"FAIL")." levels=".var_export($lv,true)." sort_order=".var_export($so,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

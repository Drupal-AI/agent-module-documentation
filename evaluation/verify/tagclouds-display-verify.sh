#!/usr/bin/env bash
# Execution VERIFY: PASS when tagclouds.settings has display_type=='count' AND page_amount==100.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("tagclouds.settings");
  $dt=$c->get("display_type"); $pa=$c->get("page_amount");
  $ok=($dt==="count" && (int)$pa===100);
  print ($ok?"PASS":"FAIL")." display_type=".var_export($dt,true)." page_amount=".var_export($pa,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

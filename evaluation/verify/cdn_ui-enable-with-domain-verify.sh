#!/usr/bin/env bash
# Execution VERIFY: PASS when status===TRUE, mapping.type==simple, mapping.domain==cdn-ui-hard.example.com.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("cdn.settings");
  $s=$c->get("status"); $t=$c->get("mapping.type"); $d=$c->get("mapping.domain");
  $ok=($s===TRUE && $t==="simple" && $d==="cdn-ui-hard.example.com");
  print ($ok?"PASS":"FAIL")." status=".var_export($s,TRUE)." type=".var_export($t,TRUE)." domain=".var_export($d,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

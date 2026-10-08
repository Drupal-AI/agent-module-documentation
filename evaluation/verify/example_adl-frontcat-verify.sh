#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d=\Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("front");
  $v=($d?$d->get("tags"):[])["page_Category"]??NULL;
  print (($v==="landing")?"PASS":"FAIL")." page_Category=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

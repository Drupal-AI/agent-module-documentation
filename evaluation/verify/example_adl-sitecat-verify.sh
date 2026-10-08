#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d=\Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("node");
  $v=($d?$d->get("tags"):[])["site_Category"]??NULL;
  print (($v==="news")?"PASS":"FAIL")." site_Category=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

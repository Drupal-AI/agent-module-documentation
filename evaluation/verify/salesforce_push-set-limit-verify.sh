#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfp_ltask");
  $v = $m ? $m->get("push_limit") : NULL;
  print ((intval($v) === 25) ? "PASS" : "FAIL") . " push_limit=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $a = \Drupal::entityTypeManager()->getStorage("salesforce_auth")->load("sfj_task");
  $p = $a ? $a->getPluginId() : NULL;
  print (($a && $p === "jwt") ? "PASS" : "FAIL") . " provider=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

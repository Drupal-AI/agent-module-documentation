#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfw_otask");
  $o = $m ? $m->get("salesforce_object_type") : NULL;
  print (($o === "Contact") ? "PASS" : "FAIL") . " salesforce_object_type=" . var_export($o, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

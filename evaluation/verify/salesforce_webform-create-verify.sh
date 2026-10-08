#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfw_task");
  $d = $m ? $m->get("drupal_entity_type") : NULL;
  print (($m && $d === "webform_submission") ? "PASS" : "FAIL") . " drupal_entity_type=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

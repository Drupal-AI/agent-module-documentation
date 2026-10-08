#!/usr/bin/env bash
# VERIFY: PASS when salesforce_mapping sfm_task exists mapping to Salesforce object 'Lead'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfm_task");
  $obj = $m ? $m->get("salesforce_object_type") : NULL;
  print (($m && $obj === "Lead") ? "PASS" : "FAIL") . " sf_object=" . var_export($obj, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

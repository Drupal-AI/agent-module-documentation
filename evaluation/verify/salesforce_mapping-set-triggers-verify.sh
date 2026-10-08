#!/usr/bin/env bash
# VERIFY: PASS when sfm_ttask has push_create AND push_update sync triggers TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfm_ttask");
  $t = $m ? $m->get("sync_triggers") : [];
  $ok = !empty($t["push_create"]) && !empty($t["push_update"]);
  print (($ok) ? "PASS" : "FAIL") . " push_create=" . var_export($t["push_create"] ?? null, TRUE) . " push_update=" . var_export($t["push_update"] ?? null, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

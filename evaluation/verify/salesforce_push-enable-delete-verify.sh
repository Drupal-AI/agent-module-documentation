#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfp_task");
  $t = $m ? $m->get("sync_triggers") : [];
  print (!empty($t["push_delete"]) ? "PASS" : "FAIL") . " push_delete=" . var_export($t["push_delete"] ?? null, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

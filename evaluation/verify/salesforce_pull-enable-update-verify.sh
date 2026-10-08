#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfl_task");
  $t = $m ? $m->get("sync_triggers") : [];
  print (!empty($t["pull_update"]) ? "PASS" : "FAIL") . " pull_update=" . var_export($t["pull_update"] ?? null, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

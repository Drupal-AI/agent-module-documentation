#!/usr/bin/env bash
# Execution VERIFY: PASS when migrate_plus.migration.msy_task exists with source.plugin == yaml,
# a non-empty source.file, and source.ids containing key 'id'. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("migrate_plus.migration.msy_task");
  $plugin = $c->get("source.plugin");
  $file = $c->get("source.file");
  $ids = $c->get("source.ids") ?: [];
  $ok = ($plugin === "yaml" && !empty($file) && array_key_exists("id", $ids));
  print ($ok ? "PASS" : "FAIL") . " plugin=" . var_export($plugin, TRUE) . " file=" . var_export($file, TRUE) . " ids=" . implode(",", array_keys($ids)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

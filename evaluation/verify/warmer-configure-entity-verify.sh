#!/usr/bin/env bash
# Live-state verification for the "configure the entity warmer" hard task.
# PASS when warmer.settings:warmers.entity has frequency == 3600 and batchSize == 100.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $entity = \Drupal::config("warmer.settings")->get("warmers.entity");
  $freq = is_array($entity) && isset($entity["frequency"]) ? (int) $entity["frequency"] : -1;
  $batch = is_array($entity) && isset($entity["batchSize"]) ? (int) $entity["batchSize"] : -1;
  $ok = ($freq === 3600 && $batch === 100);
  print ($ok ? "PASS" : "FAIL") . " frequency=" . $freq . " batchSize=" . $batch . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

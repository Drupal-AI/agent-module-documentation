#!/usr/bin/env bash
# Execution VERIFY: PASS when state key config_distro_eval_match === "MATCH", i.e. the agent
# compared config_distro_eval.cmph as read from config_distro.storage.distro against the active
# storage and found them identical (no pending distribution change for that item). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_distro_eval_match");
  print (($v === "MATCH") ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

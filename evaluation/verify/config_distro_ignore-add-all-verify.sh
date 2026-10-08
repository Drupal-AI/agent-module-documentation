#!/usr/bin/env bash
# Execution VERIFY: PASS when config_distro_ignore.settings all_collections contains
# 'config_distro_eval.keepme' (the agent added it so that config is retained on distro import).
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("config_distro_ignore.settings")->get("all_collections") ?: [];
  $ok = in_array("config_distro_eval.keepme", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " all_collections=" . json_encode(array_values($list)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when config_distro_ignore.settings default_collection contains
# 'config_distro_eval.dckeep'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("config_distro_ignore.settings")->get("default_collection") ?: [];
  $ok = in_array("config_distro_eval.dckeep", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " default_collection=" . json_encode(array_values($list)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

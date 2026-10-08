#!/usr/bin/env bash
# Execution VERIFY: PASS when config_devel.settings auto_export contains
# "node.type.article". Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("config_devel.settings")->get("auto_export") ?: [];
  $ok = in_array("node.type.article", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " auto_export=" . json_encode($list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

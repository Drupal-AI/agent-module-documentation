#!/usr/bin/env bash
# Execution VERIFY: PASS when config_devel.settings auto_import has an entry whose filename is
# modules/custom/cfgdev_task/config/install/system.only.cfgdev_task.yml. Prints PASS/FAIL.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $target = "modules/custom/cfgdev_task/config/install/system.only.cfgdev_task.yml";
  $list = \Drupal::config("config_devel.settings")->get("auto_import") ?: [];
  $ok = FALSE;
  foreach ($list as $e) { if (is_array($e) && (($e["filename"] ?? NULL) === $target)) { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " auto_import=" . json_encode($list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

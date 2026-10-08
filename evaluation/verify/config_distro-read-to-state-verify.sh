#!/usr/bin/env bash
# Execution VERIFY: PASS when state key config_distro_eval_read holds the value the agent read
# through config_distro.storage.distro, i.e. an array with marker === DISTRO123. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_distro_eval_read");
  $ok = is_array($v) && (($v["marker"] ?? NULL) === "DISTRO123");
  print ($ok ? "PASS" : "FAIL") . " value=" . json_encode(is_array($v) ? $v : $v) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when state config_distro_filter_eval_ok === "BRIDGED", i.e. the agent
# confirmed the distribution storage's copy of config_distro_eval.bridgeh (produced via the bridge's
# transform) equals the active copy. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_distro_filter_eval_ok");
  print (($v === "BRIDGED") ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

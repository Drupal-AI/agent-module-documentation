#!/usr/bin/env bash
# Execution VERIFY: PASS when config_distro_filter_eval_names is an array of config names read
# from the distribution storage (transform pipeline) and includes 'system.site'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_distro_filter_eval_names");
  $ok = is_array($v) && in_array("system.site", $v, TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . gettype($v) . " count=" . (is_array($v) ? count($v) : 0) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

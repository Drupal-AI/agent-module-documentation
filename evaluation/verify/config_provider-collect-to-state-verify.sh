#!/usr/bin/env bash
# Execution VERIFY: PASS when Drupal state key config_provider_eval_node holds an array that
# includes 'node.settings' (i.e. the agent collected node's installable config via
# config_provider and stored the names). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_provider_eval_node");
  $ok = is_array($v) && in_array("node.settings", $v, TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . gettype($v) . " count=" . (is_array($v) ? count($v) : 0) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

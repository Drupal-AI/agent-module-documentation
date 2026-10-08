#!/usr/bin/env bash
# Execution VERIFY: PASS when state key config_provider_eval_user is an array including
# 'user.role.authenticated' (agent collected the user module's installable config via
# config_provider and stored the names). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_provider_eval_user");
  $ok = is_array($v) && in_array("user.role.authenticated", $v, TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . gettype($v) . " count=" . (is_array($v) ? count($v) : 0) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

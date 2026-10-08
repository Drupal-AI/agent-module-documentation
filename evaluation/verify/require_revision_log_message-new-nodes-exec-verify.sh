#!/usr/bin/env bash
# Execution VERIFY: PASS when require_for_new_nodes === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("require_revision_log_message.adminsettings")->get("require_for_new_nodes");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " require_for_new_nodes=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when the dubbot_toolbar submodule is installed/enabled.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = \Drupal::moduleHandler()->moduleExists("dubbot_toolbar");
  print ($ok ? "PASS" : "FAIL") . " dubbot_toolbar_enabled=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

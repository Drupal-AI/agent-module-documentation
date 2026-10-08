#!/usr/bin/env bash
# Execution VERIFY: PASS when mercury_editor_inline_editor is enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = \Drupal::moduleHandler()->moduleExists("mercury_editor_inline_editor");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

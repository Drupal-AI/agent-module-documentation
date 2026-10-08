#!/usr/bin/env bash
# PASS when both leading and trailing context lines are set to 2.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("config_log.settings");
  $l = (int) $c->get("leading_context_lines"); $t = (int) $c->get("trailing_context_lines");
  $ok = ($l === 2 && $t === 2);
  print ($ok ? "PASS" : "FAIL") . " leading=$l trailing=$t\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

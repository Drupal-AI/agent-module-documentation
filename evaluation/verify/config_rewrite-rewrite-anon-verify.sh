#!/usr/bin/env bash
# HARD execution verify for the "rewrite user.settings anonymous name" task.
# PASS (exit 0) iff the live user.settings anonymous name equals the required target value.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $anon = \Drupal::config("user.settings")->get("anonymous");
  $ok = ($anon === "Guest User");
  print ($ok ? "PASS" : "FAIL") . " anonymous=[" . $anon . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

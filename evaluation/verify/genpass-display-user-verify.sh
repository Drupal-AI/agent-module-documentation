#!/usr/bin/env bash
# Live-state verification: genpass.settings:genpass_display shows the generated password to
# the USER — i.e. value 2 (user) or 3 (both). Prints PASS/FAIL, exits 0/1. No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = (int) \Drupal::config("genpass.settings")->get("genpass_display");
  $ok = ($d === 2 || $d === 3);
  print ($ok ? "PASS" : "FAIL") . " genpass_display=" . $d . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when twig_debugger.settings:enabled === 1 (Twig debugging turned on
# via the module config). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("twig_debugger.settings")->get("enabled");
  $ok = ((int) $v === 1);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

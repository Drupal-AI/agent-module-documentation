#!/usr/bin/env bash
# Execution VERIFY: PASS when Twig debugging is OFF in the module config, i.e.
# twig_debugger.settings:enabled is not 1 (0, empty, or unset). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("twig_debugger.settings")->get("enabled");
  $ok = ((int) $v !== 1);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

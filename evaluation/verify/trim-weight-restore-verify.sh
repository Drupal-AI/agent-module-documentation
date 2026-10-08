#!/usr/bin/env bash
# Execution VERIFY: PASS when Trim's module weight in core.extension is a large positive value
# (>= 1000) so it runs its hook_form_alter last and validates first. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("core.extension")->get("module.trim");
  $ok = (is_int($w) || is_numeric($w)) && ((int) $w >= 1000);
  print ($ok ? "PASS" : "FAIL") . " trim_weight=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

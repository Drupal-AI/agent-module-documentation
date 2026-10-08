#!/usr/bin/env bash
# Execution VERIFY: PASS when inline styles are DISABLED for sections in the module settings
# (allowed_section_attributes.style is falsey). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("layout_custom_section_classes.settings")->get("allowed_section_attributes.style");
  $ok = empty($v);
  print ($ok ? "PASS" : "FAIL") . " allowed_section_attributes.style=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

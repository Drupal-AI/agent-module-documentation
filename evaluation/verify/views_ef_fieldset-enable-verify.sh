#!/usr/bin/env bash
# Execution VERIFY: PASS when the vef_test view's default display has the Views EF Fieldset
# extender enabled === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vef_test");
  $d = $v ? $v->get("display") : NULL;
  $en = $d["default"]["display_options"]["display_extenders"]["views_ef_fieldset"]["views_ef_fieldset"]["enabled"] ?? NULL;
  $ok = ($en === TRUE || $en === 1 || $en === "1");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

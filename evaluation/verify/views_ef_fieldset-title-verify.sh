#!/usr/bin/env bash
# Execution VERIFY: PASS when the vef_test view's root exposed-form container title == 'My Filters'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vef_test");
  $d = $v ? $v->get("display") : NULL;
  $t = $d["default"]["display_options"]["display_extenders"]["views_ef_fieldset"]["views_ef_fieldset"]["options"]["sort"]["root"]["title"] ?? NULL;
  $ok = ($t === "My Filters");
  print ($ok ? "PASS" : "FAIL") . " root.title=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

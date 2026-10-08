#!/usr/bin/env bash
# Execution VERIFY: PASS when vls_null_view sort keeps allowed_values ON and null_heavy truthy.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vls_null_view");
  $s = $v ? ($v->getDisplay("default")["display_options"]["sorts"]["field_vls_null_value"] ?? NULL) : NULL;
  $av = $s["allowed_values"] ?? NULL; $nh = $s["null_heavy"] ?? NULL;
  $ok = (!empty($av) && $av !== "0" && !empty($nh) && $nh !== "0");
  print ($ok ? "PASS" : "FAIL") . " allowed_values=" . var_export($av, TRUE) . " null_heavy=" . var_export($nh, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

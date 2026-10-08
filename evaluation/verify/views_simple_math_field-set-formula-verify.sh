#!/usr/bin/env bash
# Execution VERIFY: PASS when the vsmf_calc Simple Math Field formula multiplies @nid by 100
# (references @nid and contains 100). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vsmf_calc");
  $formula = "";
  if ($v) {
    $display = $v->get("display");
    $formula = $display["default"]["display_options"]["fields"]["field_views_simple_math_field"]["fieldset_one"]["formula"] ?? "";
  }
  $ok = (strpos($formula, "@nid") !== FALSE) && (strpos($formula, "100") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " formula=" . var_export($formula, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

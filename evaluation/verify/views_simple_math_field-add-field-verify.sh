#!/usr/bin/env bash
# Execution VERIFY: PASS when the vsmf_task view's default display has a Simple Math Field
# (plugin_id field_views_simple_math_field) with a non-empty formula. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vsmf_task");
  $found = FALSE; $formula = NULL;
  if ($v) {
    $display = $v->get("display");
    $fields = $display["default"]["display_options"]["fields"] ?? [];
    foreach ($fields as $f) {
      $pid = $f["plugin_id"] ?? ($f["field"] ?? "");
      if ($pid === "field_views_simple_math_field") {
        $formula = $f["fieldset_one"]["formula"] ?? "";
        if (trim((string) $formula) !== "") { $found = TRUE; }
      }
    }
  }
  print ($found ? "PASS" : "FAIL") . " formula=" . var_export($formula, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

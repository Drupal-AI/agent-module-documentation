#!/usr/bin/env bash
# Execution VERIFY: PASS when cvf_task2_view's default display has a filter handler with
# plugin_id 'node_granular_date_filter' and granular_field_name 'created'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("cvf_task2_view");
  $ok = FALSE; $field = "none";
  if ($v) {
    $filters = $v->get("display")["default"]["display_options"]["filters"] ?? [];
    foreach ($filters as $f) {
      if (($f["plugin_id"] ?? "") === "node_granular_date_filter") {
        $field = $f["granular_field_name"] ?? "";
        if ($field === "created") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " granular_field_name=" . var_export($field, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

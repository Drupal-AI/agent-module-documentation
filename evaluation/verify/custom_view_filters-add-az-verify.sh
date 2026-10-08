#!/usr/bin/env bash
# Execution VERIFY: PASS when cvf_task_view's default display has a filter handler with
# plugin_id 'custom_az_filter' and az_field_name 'title'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("cvf_task_view");
  $ok = FALSE; $field = "none";
  if ($v) {
    $filters = $v->get("display")["default"]["display_options"]["filters"] ?? [];
    foreach ($filters as $f) {
      if (($f["plugin_id"] ?? "") === "custom_az_filter") {
        $field = $f["az_field_name"] ?? "";
        if ($field === "title") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " az_field_name=" . var_export($field, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

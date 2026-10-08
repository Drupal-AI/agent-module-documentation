#!/usr/bin/env bash
# Execution VERIFY: PASS when the vls_task_view sort on field_vls_task_value uses plugin
# sort_allowed_values with allowed_values truthy ('Sort by allowed values' ON).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vls_task_view");
  $s = $v ? ($v->getDisplay("default")["display_options"]["sorts"]["field_vls_task_value"] ?? NULL) : NULL;
  $pid = $s["plugin_id"] ?? "none";
  $av = $s["allowed_values"] ?? NULL;
  $ok = ($pid === "sort_allowed_values" && !empty($av) && $av !== "0");
  print ($ok ? "PASS" : "FAIL") . " plugin_id=" . $pid . " allowed_values=" . var_export($av, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

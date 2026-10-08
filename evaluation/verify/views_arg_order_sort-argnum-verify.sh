#!/usr/bin/env bash
# Execution VERIFY (views_arg_order_sort, default/inherit): PASS when vaos_task_view has a sort
# using plugin views_arg_order_sort_default reading argument_number 1. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vaos_task_view");
  $sorts = $v ? ($v->get("display")["default"]["display_options"]["sorts"] ?? []) : [];
  $found = NULL;
  foreach ($sorts as $s) { if (($s["plugin_id"] ?? "") === "views_arg_order_sort_default") { $found = $s; break; } }
  $an = $found["argument_number"] ?? NULL;
  $ok = ($found !== NULL && (int) $an === 1);
  print ($ok ? "PASS" : "FAIL") . " plugin=" . ($found ? "views_arg_order_sort_default" : "none") . " argument_number=" . var_export($an, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

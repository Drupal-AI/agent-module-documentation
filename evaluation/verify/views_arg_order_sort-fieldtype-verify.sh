#!/usr/bin/env bash
# Execution VERIFY (views_arg_order_sort, explicit field type): PASS when vaos_task_view has a
# sort using plugin views_arg_order_sort_default with inherit_type false and field_type
# node::nid. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vaos_task_view");
  $sorts = $v ? ($v->get("display")["default"]["display_options"]["sorts"] ?? []) : [];
  $found = NULL;
  foreach ($sorts as $s) { if (($s["plugin_id"] ?? "") === "views_arg_order_sort_default") { $found = $s; break; } }
  $inh = $found["inherit_type"] ?? NULL;
  $ft = $found["field_type"] ?? NULL;
  $ok = ($found !== NULL && ($inh === FALSE || $inh === 0 || $inh === "0") && $ft === "node::nid");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . ($found ? "views_arg_order_sort_default" : "none") . " inherit_type=" . var_export($inh, TRUE) . " field_type=" . var_export($ft, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

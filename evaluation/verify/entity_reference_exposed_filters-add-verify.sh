#!/usr/bin/env bash
# Execution VERIFY: PASS when the eref_eval view's default display has a filter whose plugin_id is
# eref_node_titles.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("eref_eval");
  $filters = $v ? ($v->get("display")["default"]["display_options"]["filters"] ?? []) : [];
  $ok = FALSE;
  foreach ($filters as $f) { if (($f["plugin_id"] ?? NULL) === "eref_node_titles") { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " view=" . ($v ? "exists" : "missing") . " filters=" . implode(",", array_keys($filters)) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

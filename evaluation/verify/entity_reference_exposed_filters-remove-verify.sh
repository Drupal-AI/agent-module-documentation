#!/usr/bin/env bash
# Execution VERIFY: PASS when the eref_eval view's default display has NO filter with plugin_id
# eref_node_titles (i.e. the agent removed it). View must still exist.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("eref_eval");
  if (!$v) { print "FAIL view=missing\n"; exit; }
  $filters = $v->get("display")["default"]["display_options"]["filters"] ?? [];
  $has = FALSE;
  foreach ($filters as $f) { if (($f["plugin_id"] ?? NULL) === "eref_node_titles") { $has = TRUE; } }
  print ((!$has) ? "PASS" : "FAIL") . " filters=" . implode(",", array_keys($filters)) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when Menu Entity Index is configured to track the 'node' entity
# type AND the 'main' menu (either via the menus list or all_menus). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("menu_entity_index.configuration");
  $types = array_values((array) $c->get("entity_types"));
  $menus = array_values((array) $c->get("menus"));
  $all = (bool) $c->get("all_menus");
  $ok = in_array("node", $types, TRUE) && ($all || in_array("main", $menus, TRUE));
  print ($ok ? "PASS" : "FAIL") . " types=" . implode("|", $types) . " menus=" . implode("|", $menus) . " all_menus=" . var_export($all, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

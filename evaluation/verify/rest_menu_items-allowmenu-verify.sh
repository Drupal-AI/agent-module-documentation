#!/usr/bin/env bash
# Execution VERIFY (rest_menu_items): PASS when the footer menu is marked as an allowed/exposed
# menu in rest_menu_items.config allowed_menus (its checkbox value is truthy, i.e. 'footer').
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $allowed = \Drupal::config("rest_menu_items.config")->get("allowed_menus") ?: [];
  $enabled = in_array("footer", $allowed, TRUE);
  print ($enabled ? "PASS" : "FAIL") . " allowed_menus=" . json_encode($allowed) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

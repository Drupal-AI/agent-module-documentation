#!/usr/bin/env bash
# Live-state verification for "add the main menu to the toolbar labeled Site Menu".
# PASS (exit 0) when a toolbar_menu_element config entity exists with menu == "main" and
# label == "Site Menu". Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  error_reporting(E_ERROR);
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("toolbar_menu_element")->loadMultiple() as $id => $e) {
    if ($e->get("menu") === "main") {
      $label = (string) $e->label();
      $detail = " id=" . $id . " menu=main label=" . $label;
      if ($label === "Site Menu") { $ok = TRUE; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

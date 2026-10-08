#!/usr/bin/env bash
# Live-state verification for "add the admin menu to the toolbar with rewrite_label enabled".
# PASS (exit 0) when a toolbar_menu_element config entity exists with menu == "admin" and
# rewrite_label == TRUE. Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  error_reporting(E_ERROR);
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("toolbar_menu_element")->loadMultiple() as $id => $e) {
    if ($e->get("menu") === "admin") {
      $rw = $e->get("rewrite_label") ? 1 : 0;
      $detail = " id=" . $id . " menu=admin rewrite_label=" . $rw;
      if ($rw === 1) { $ok = TRUE; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

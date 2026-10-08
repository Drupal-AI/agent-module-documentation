#!/usr/bin/env bash
# Execution VERIFY: PASS when jquery_ui_sortable is enabled AND the jquery_ui_sortable/sortable
# library resolves with a non-empty JS asset. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("jquery_ui_sortable");
  $lib = $enabled ? \Drupal::service("library.discovery")->getLibraryByName("jquery_ui_sortable", "sortable") : FALSE;
  $has_js = is_array($lib) && !empty($lib["js"]);
  $ok = $enabled && $has_js;
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled?"y":"n") . " library_js=" . ($has_js?"y":"n") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

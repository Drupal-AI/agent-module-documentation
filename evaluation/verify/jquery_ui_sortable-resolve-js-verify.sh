#!/usr/bin/env bash
# Execution VERIFY: PASS when the jquery_ui_sortable/sortable library resolves to a JS asset whose
# path references the jQuery UI sortable file (contains 'sortable'). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("jquery_ui_sortable");
  $path = "";
  if ($enabled) {
    $lib = \Drupal::service("library.discovery")->getLibraryByName("jquery_ui_sortable", "sortable");
    if (is_array($lib) && !empty($lib["js"][0]["data"])) { $path = $lib["js"][0]["data"]; }
  }
  $ok = $enabled && (stripos($path, "sortable") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled?"y":"n") . " js_path=" . var_export($path, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

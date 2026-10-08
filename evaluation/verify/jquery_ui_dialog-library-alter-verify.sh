#!/usr/bin/env bash
# Execution VERIFY: PASS when the live definition of jquery_ui_dialog/dialog reports the
# version 1.13.2-sitepatch (i.e. a hook_library_info_alter() implementation is in effect and
# the caches were rebuilt). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $def = \Drupal::service("library.discovery")->getLibraryByName("jquery_ui_dialog", "dialog");
  $version = $def["version"] ?? "none";
  print (($version === "1.13.2-sitepatch") ? "PASS" : "FAIL") . " version=" . $version . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

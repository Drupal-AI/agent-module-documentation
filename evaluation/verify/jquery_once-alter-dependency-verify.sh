#!/usr/bin/env bash
# Execution VERIFY: PASS when the live library registry reports that core/drupal.debounce now
# depends on core/jquery.once (added by an enabled custom module's hook_library_info_alter()).
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lib = \Drupal::service("library.discovery")->getLibraryByName("core", "drupal.debounce");
  $deps = $lib["dependencies"] ?? [];
  $ok = in_array("core/jquery.once", $deps, TRUE);
  print ($ok ? "PASS" : "FAIL") . " drupal.debounce_dependencies=[" . implode(", ", $deps) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when a module jqd_task is installed AND at least one of the asset
# libraries it registers declares a dependency on jquery_ui_dialog/dialog (as resolved by the
# live library.discovery service). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("jqd_task")) {
    print "FAIL module jqd_task not installed\n";
    return;
  }
  $libs = \Drupal::service("library.discovery")->getLibrariesByExtension("jqd_task");
  $hit = NULL;
  foreach ($libs as $name => $def) {
    if (in_array("jquery_ui_dialog/dialog", $def["dependencies"] ?? [], TRUE)) { $hit = $name; break; }
  }
  print ($hit ? "PASS" : "FAIL") . " libraries=" . implode(",", array_keys($libs)) .
    " matched=" . ($hit ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

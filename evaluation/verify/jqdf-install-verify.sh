#!/usr/bin/env bash
# Execution VERIFY: PASS when the module is installed AND its global-scripts library resolves in the
# live library registry. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("jquery_deprecated_functions");
  $lib = \Drupal::service("library.discovery")->getLibraryByName("jquery_deprecated_functions", "global-scripts");
  $ok = ($enabled && !empty($lib));
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled ? "yes" : "no") . " library=" . (!empty($lib) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

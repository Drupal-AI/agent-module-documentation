#!/usr/bin/env bash
# Execution VERIFY: PASS when the example_blocks 'blocks' asset library is discoverable (which
# requires the module to be enabled). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lib = \Drupal::service("library.discovery")->getLibraryByName("example_blocks", "blocks");
  $ok = (bool) $lib;
  print ($ok ? "PASS" : "FAIL") . " example_blocks/blocks=" . ($ok ? "found" : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

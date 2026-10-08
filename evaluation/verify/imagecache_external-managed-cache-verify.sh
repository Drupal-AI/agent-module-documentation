#!/usr/bin/env bash
# Execution VERIFY: PASS when the cache directory is 'ice_cache' AND file management is 'managed'.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("imagecache_external.settings");
  $dir = (string) $c->get("imagecache_directory");
  $mgmt = (string) $c->get("imagecache_external_management");
  $ok = ($dir === "ice_cache" && $mgmt === "managed");
  print ($ok ? "PASS" : "FAIL") . " directory=" . var_export($dir, TRUE) . " management=" . var_export($mgmt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

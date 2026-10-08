#!/usr/bin/env bash
# Execution VERIFY: PASS when cms_content_sync_simple_sitemap is enabled. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = \Drupal::moduleHandler()->moduleExists("cms_content_sync_simple_sitemap");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

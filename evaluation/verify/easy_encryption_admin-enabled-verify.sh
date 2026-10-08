#!/usr/bin/env bash
# Execution VERIFY: PASS when easy_encryption_admin is installed and its keys route exists. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("easy_encryption_admin")) { print "FAIL not-installed\n"; return; }
  $exists = FALSE;
  try { \Drupal::service("router.route_provider")->getRouteByName("easy_encryption_admin.keys"); $exists = TRUE; } catch (\Throwable $e) {}
  print ($exists ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when the deprecated views_dependent_filter module is NOT installed
# (the correct migration end state). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $exists = \Drupal::moduleHandler()->moduleExists("views_dependent_filter");
  print ($exists ? "FAIL" : "PASS") . " views_dependent_filter_installed=" . var_export($exists, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

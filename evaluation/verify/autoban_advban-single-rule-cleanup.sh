#!/usr/bin/env bash
# Execution CLEANUP (autoban_advban): delete rule autoban_test_single. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("autoban_test_single")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: rule autoban_test_single removed"

#!/usr/bin/env bash
# Introspection CLEANUP (autoban_advban): delete rule ab_test_advban_single. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_advban_single")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: rule ab_test_advban_single removed"

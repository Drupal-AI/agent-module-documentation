#!/usr/bin/env bash
# Introspection CLEANUP (autoban_ban): delete rule ab_test_ban2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_ban2")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: rule ab_test_ban2 removed"

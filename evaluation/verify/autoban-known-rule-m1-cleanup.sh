#!/usr/bin/env bash
# Introspection CLEANUP: delete the ab_test_m1 autoban rule created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("ab_test_m1")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: autoban rule ab_test_m1 removed"

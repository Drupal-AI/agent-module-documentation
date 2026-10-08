#!/usr/bin/env bash
# Introspection CLEANUP: delete the ab_test_m2 autoban rule. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("ab_test_m2")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: autoban rule ab_test_m2 removed"

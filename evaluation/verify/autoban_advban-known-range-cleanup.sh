#!/usr/bin/env bash
# Introspection CLEANUP (autoban_advban): delete rule ab_test_advban. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("ab_test_advban")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: rule ab_test_advban removed"

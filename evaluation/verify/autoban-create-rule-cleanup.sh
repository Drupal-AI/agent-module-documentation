#!/usr/bin/env bash
# Execution CLEANUP: delete the autoban_test_404 rule to restore baseline.
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_404")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: autoban rule autoban_test_404 removed"

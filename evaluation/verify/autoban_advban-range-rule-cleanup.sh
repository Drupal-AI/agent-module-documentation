#!/usr/bin/env bash
# Execution CLEANUP (autoban_advban): remove rule autoban_test_range to restore baseline.
# so verify FAILS until the agent creates it with the advban_range provider. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_range")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: rule autoban_test_range removed"

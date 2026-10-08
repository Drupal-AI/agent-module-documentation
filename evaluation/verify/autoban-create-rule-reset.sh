#!/usr/bin/env bash
# Execution RESET: ensure the target autoban rule 'autoban_test_404' does NOT exist, so verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_404")) { $e->delete(); }' >/dev/null 2>&1
echo "reset: autoban rule autoban_test_404 absent"

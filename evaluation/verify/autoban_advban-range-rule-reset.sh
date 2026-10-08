#!/usr/bin/env bash
# Execution RESET (autoban_advban): ensure the target rule 'autoban_test_range' does NOT exist,
# so verify FAILS until the agent creates it with the advban_range provider. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_range")) { $e->delete(); }' >/dev/null 2>&1
echo "reset: rule autoban_test_range absent"

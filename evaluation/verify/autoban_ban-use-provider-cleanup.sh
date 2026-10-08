#!/usr/bin/env bash
# Execution CLEANUP (autoban_ban): remove rule autoban_test_bansub to restore baseline.
# 'autoban_test_bansub' does NOT exist, so verify FAILS until the agent creates it with the
# core Ban provider. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en autoban_ban -y >/dev/null 2>&1 || true
drush php:eval 'if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_bansub")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: rule autoban_test_bansub removed"

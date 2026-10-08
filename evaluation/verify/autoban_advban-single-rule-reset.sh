#!/usr/bin/env bash
# Execution RESET (autoban_advban): ensure rule autoban_test_single does NOT exist, so verify
# FAILS until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("autoban_test_single")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: rule autoban_test_single absent"

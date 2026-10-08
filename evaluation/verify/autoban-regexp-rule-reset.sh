#!/usr/bin/env bash
# Execution RESET: restore baseline for the REGEXP-mode hard case — clear the
# autoban.settings 'autoban_query_mode' key (shipped baseline: unset) and remove the target
# rule 'autoban_test_403'. So verify FAILS until the agent sets REGEXP mode AND creates the
# rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("autoban.settings")->clear("autoban_query_mode")->save();
  if ($e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_403")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: autoban_query_mode cleared; rule autoban_test_403 absent"

#!/usr/bin/env bash
# Execution RESET: remove all Terms & Conditions versions so verify FAILS until the agent
# creates one. Baseline site has none. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("legal_conditions");
  if ($all = $s->loadMultiple()) { $s->delete($all); }
' >/dev/null 2>&1
echo "reset: cleared all legal_conditions (no T&C set)"

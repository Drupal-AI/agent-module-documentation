#!/usr/bin/env bash
# Execution RESET: delete any promotion named 'cpba_fixed' so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadByProperties(["name"=>"cpba_fixed"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: promotion cpba_fixed removed"

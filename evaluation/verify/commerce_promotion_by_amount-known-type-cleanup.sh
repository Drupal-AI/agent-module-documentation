#!/usr/bin/env bash
# Introspection CLEANUP: remove the cpba_known promotion. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadByProperties(["name"=>"cpba_known"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: promotion cpba_known removed"

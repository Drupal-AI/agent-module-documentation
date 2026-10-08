#!/usr/bin/env bash
# Introspection CLEANUP: delete the cpl_probe_list price list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_probe_list"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cpl_probe_list removed"

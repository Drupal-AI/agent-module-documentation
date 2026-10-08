#!/usr/bin/env bash
# Introspection CLEANUP: delete the CSL Main Depot stock location. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("commerce_stock_location"); foreach($s->loadByProperties(["name"=>"CSL Main Depot"]) as $l){$l->delete();}' >/dev/null 2>&1
echo "cleanup: stock location 'CSL Main Depot' removed"

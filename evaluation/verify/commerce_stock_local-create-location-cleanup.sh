#!/usr/bin/env bash
# Execution CLEANUP: delete the 'CSL West Warehouse' stock location. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("commerce_stock_location"); foreach($s->loadByProperties(["name"=>"CSL West Warehouse"]) as $l){$l->delete();}' >/dev/null 2>&1
echo "cleanup: stock location 'CSL West Warehouse' removed"

#!/usr/bin/env bash
# Execution RESET: ensure no stock location named 'CSL West Warehouse' exists, so verify FAILS
# until the agent creates one. Does NOT touch the default location. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("commerce_stock_location"); foreach($s->loadByProperties(["name"=>"CSL West Warehouse"]) as $l){$l->delete();}' >/dev/null 2>&1
echo "reset: no stock location named 'CSL West Warehouse'"

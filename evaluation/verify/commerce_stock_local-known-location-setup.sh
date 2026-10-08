#!/usr/bin/env bash
# Introspection SETUP: create a stock location with a known name for an agent to read back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_stock_location");
  foreach ($s->loadByProperties(["name" => "CSL Main Depot"]) as $l) { $l->delete(); }
  $s->create(["type" => "default", "name" => "CSL Main Depot", "status" => 1])->save();
' >/dev/null 2>&1
echo "setup: stock location 'CSL Main Depot' created"

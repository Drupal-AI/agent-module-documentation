#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadByProperties(["name"=>"cpba_plugin"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: promotion cpba_plugin removed"

#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_order_report");
  foreach ($s->loadByProperties(["mail" => "buyer5150@example.test"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: commerce_order_report for buyer5150@example.test removed"

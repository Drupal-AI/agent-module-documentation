#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_order_report");
  foreach ($s->loadByProperties(["mail" => "creport-count@example.test"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: order_report entities for creport-count@example.test removed"

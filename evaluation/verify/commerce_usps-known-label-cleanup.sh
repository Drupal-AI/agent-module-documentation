#!/usr/bin/env bash
# Introspection CLEANUP: delete cusps_known shipping method and the cusps_store store. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ms = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method");
  if ($e = $ms->loadByProperties(["name" => "cusps_known"])) { $ms->delete($e); }
  $ss = \Drupal::entityTypeManager()->getStorage("commerce_store");
  if ($s = $ss->loadByProperties(["name" => "cusps_store"])) { $ss->delete($s); }
' >/dev/null 2>&1
echo "cleanup: cusps_known and cusps_store removed"

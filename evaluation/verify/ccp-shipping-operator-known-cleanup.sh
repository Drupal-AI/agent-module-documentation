#!/usr/bin/env bash
# Introspection CLEANUP: delete the throwaway ccp_eval_ship shipping method and ccp_eval_store. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_shipping_method")->loadByProperties(["name" => "ccp_eval_ship"]) as $m) { $m->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_store")->loadByProperties(["name" => "ccp_eval_store"]) as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ccp_eval_ship and ccp_eval_store removed"

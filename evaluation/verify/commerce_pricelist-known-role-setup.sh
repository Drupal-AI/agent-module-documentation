#!/usr/bin/env bash
# Introspection SETUP: create a customer role and an enabled price list limited to that role,
# so the agent must inspect the price list to report which role it targets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  use Drupal\commerce_pricelist\Entity\PriceList;
  if (!Role::load("cpl_probe_role")) { Role::create(["id"=>"cpl_probe_role","label"=>"CPL Probe Role"])->save(); }
  $e = \Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_role_list"]);
  if (!$e) { PriceList::create(["type"=>"commerce_product_variation","name"=>"cpl_role_list","status"=>1,"customer_roles"=>["cpl_probe_role"]])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cpl_role_list limited to role cpl_probe_role"

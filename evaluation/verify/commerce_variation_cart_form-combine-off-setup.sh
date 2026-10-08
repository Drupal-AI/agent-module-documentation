#!/usr/bin/env bash
# Introspection SETUP (cvcf M2): show the add-to-cart pseudo-field on the default variation
# display but set 'combine' to FALSE. The agent must inspect the live display to report the
# combine value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("commerce_product_variation","default","default");
  $d->setComponent("commerce_variation_cart_form", ["weight"=>10,"region"=>"content"])
    ->setThirdPartySetting("commerce_variation_cart_form","combine",FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_product_variation.default.default shows cart form, combine=FALSE"

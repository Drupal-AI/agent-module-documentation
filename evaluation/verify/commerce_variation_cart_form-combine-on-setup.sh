#!/usr/bin/env bash
# Introspection SETUP (cvcf M1): on the default product variation type's default view display,
# show the add-to-cart pseudo-field (commerce_variation_cart_form) and ENABLE the 'combine'
# third-party setting. The agent must inspect the live display to report whether combining is on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("commerce_product_variation","default","default");
  $d->setComponent("commerce_variation_cart_form", ["weight"=>10,"region"=>"content"])
    ->setThirdPartySetting("commerce_variation_cart_form","combine",TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_product_variation.default.default shows cart form, combine=TRUE"

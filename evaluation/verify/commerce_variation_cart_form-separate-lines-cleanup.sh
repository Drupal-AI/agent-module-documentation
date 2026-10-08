#!/usr/bin/env bash
# Execution CLEANUP (cvcf H2): ensure the add-to-cart pseudo-field is NOT shown on the default
# variation display and 'combine' is cleared, so verify FAILS until the agent shows the form.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("commerce_product_variation","default","default");
  $d->removeComponent("commerce_variation_cart_form")->unsetThirdPartySetting("commerce_variation_cart_form","combine")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cart form hidden + combine cleared on commerce_product_variation.default.default"

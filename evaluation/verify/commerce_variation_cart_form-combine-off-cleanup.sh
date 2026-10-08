#!/usr/bin/env bash
# Introspection CLEANUP (cvcf M2): remove the cart-form pseudo-field and the combine setting
# from the default variation display (restore baseline: form not shown). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("commerce_product_variation","default","default");
  $d->removeComponent("commerce_variation_cart_form")->unsetThirdPartySetting("commerce_variation_cart_form","combine")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cart form pseudo-field + combine setting removed from default variation display"

#!/usr/bin/env bash
# Introspection SETUP: enable AJAX add-to-cart on the default commerce_product display by setting
# the enable_ajax third-party setting on its 'variations' component, so the agent can detect it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $d = $repo->getViewDisplay("commerce_product", "default", "default");
  $c = $d->getComponent("variations");
  if ($c) {
    $c["third_party_settings"]["commerce_ajax_atc"]["enable_ajax"] = TRUE;
    $d->setComponent("variations", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_product.default.default variations component enable_ajax=TRUE"

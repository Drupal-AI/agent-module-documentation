#!/usr/bin/env bash
# Execution RESET: ensure the default commerce_product display's 'variations' component uses the
# commerce_add_to_cart formatter with enable_ajax NOT set, so verify FAILS until the agent turns
# AJAX on for that display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $d = $repo->getViewDisplay("commerce_product", "default", "default");
  $c = $d->getComponent("variations");
  if ($c) {
    unset($c["third_party_settings"]["commerce_ajax_atc"]);
    $d->setComponent("variations", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: default product display variations component has no enable_ajax"

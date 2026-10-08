#!/usr/bin/env bash
# Execution CLEANUP: remove the enable_ajax third-party setting from the default product display.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $d = $repo->getViewDisplay("commerce_product", "default", "default");
  $c = $d->getComponent("variations");
  if ($c && isset($c["third_party_settings"]["commerce_ajax_atc"])) {
    unset($c["third_party_settings"]["commerce_ajax_atc"]);
    $d->setComponent("variations", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: enable_ajax removed from default product display"

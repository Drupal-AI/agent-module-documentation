#!/usr/bin/env bash
# Introspection CLEANUP: remove the order_fields:checkout pane from the default flow (baseline).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("commerce_checkout.commerce_checkout_flow.default");
  $conf = $cfg->get("configuration");
  unset($conf["panes"]["order_fields:checkout"]);
  $cfg->set("configuration", $conf)->save();
' >/dev/null 2>&1
echo "cleanup: order_fields:checkout pane removed from default flow"

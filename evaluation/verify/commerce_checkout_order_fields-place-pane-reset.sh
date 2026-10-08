#!/usr/bin/env bash
# Execution RESET: ensure the order_fields:checkout pane is NOT placed on the default flow so the
# verify FAILS until the agent adds it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("commerce_checkout.commerce_checkout_flow.default");
  $conf = $cfg->get("configuration");
  unset($conf["panes"]["order_fields:checkout"]);
  $cfg->set("configuration", $conf)->save();
' >/dev/null 2>&1
echo "reset: order_fields:checkout pane absent from default flow"

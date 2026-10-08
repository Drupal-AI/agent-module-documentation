#!/usr/bin/env bash
# Introspection SETUP: place the order_fields:checkout pane with a fieldset wrapper and a known
# display label so the agent can read the label back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("commerce_checkout.commerce_checkout_flow.default");
  $conf = $cfg->get("configuration");
  $conf["panes"]["order_fields:checkout"] = [
    "step" => "order_information", "weight" => 5,
    "wrapper_element" => "fieldset", "display_label" => "Order comments",
  ];
  $cfg->set("configuration", $conf)->save();
' >/dev/null 2>&1
echo "setup: order_fields:checkout pane wrapper=fieldset display_label='Order comments'"

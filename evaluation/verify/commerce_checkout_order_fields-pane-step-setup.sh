#!/usr/bin/env bash
# Introspection SETUP: place the derived 'order_fields:checkout' pane on the 'review' step of the
# default checkout flow so the agent can read which step it is on. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("commerce_checkout.commerce_checkout_flow.default");
  $conf = $cfg->get("configuration");
  $conf["panes"]["order_fields:checkout"] = [
    "step" => "review", "weight" => 3,
    "wrapper_element" => "container", "display_label" => "Order fields",
  ];
  $cfg->set("configuration", $conf)->save();
' >/dev/null 2>&1
echo "setup: order_fields:checkout pane placed on step=review"

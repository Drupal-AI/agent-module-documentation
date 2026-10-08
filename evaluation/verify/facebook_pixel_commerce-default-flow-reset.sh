#!/usr/bin/env bash
# Execution RESET: make sure facebook_pixel_commerce is enabled but its facebook_checkout
# pane is explicitly DISABLED in the default checkout flow (step "_disabled"), so verify
# FAILS on empty state. Note: simply deleting the pane key is NOT enough - a pane that is
# absent from configuration.panes falls back to its plugin default_step
# (order_information) and would still fire. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en facebook_pixel_commerce -y >/dev/null 2>&1
drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  if ($flow) {
    $c = $flow->get("configuration");
    $c["panes"]["facebook_checkout"] = ["step" => "_disabled", "weight" => 99];
    $flow->set("configuration", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: facebook_checkout pane set to step=_disabled in commerce_checkout_flow default"

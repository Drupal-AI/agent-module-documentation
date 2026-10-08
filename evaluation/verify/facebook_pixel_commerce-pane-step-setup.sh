#!/usr/bin/env bash
# Introspection SETUP: place the facebook_checkout pane in the DEFAULT commerce checkout flow
# on the 'review' step (not its default 'order_information'), so the agent must read the live
# flow config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en facebook_pixel_commerce -y >/dev/null 2>&1
drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  if ($flow) {
    $config = $flow->get("configuration");
    $config["panes"]["facebook_checkout"] = ["step" => "review", "weight" => 11];
    $flow->set("configuration", $config)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facebook_checkout pane added to commerce_checkout_flow default at step=review weight=11"

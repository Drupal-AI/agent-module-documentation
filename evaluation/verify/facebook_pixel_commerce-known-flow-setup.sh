#!/usr/bin/env bash
# Introspection SETUP: create a SECOND checkout flow (fbpc_known_flow) that runs the
# facebook_checkout pane on order_information, and explicitly DISABLE that pane in the
# "default" flow (step "_disabled" - deleting the key would leave the pane active on its
# plugin default step), so exactly one flow triggers InitiateCheckout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en facebook_pixel_commerce -y >/dev/null 2>&1
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow");
  if ($default = $storage->load("default")) {
    $c = $default->get("configuration");
    $c["panes"]["facebook_checkout"] = ["step" => "_disabled", "weight" => 99];
    $default->set("configuration", $c)->save();
  }
  $flow = $storage->load("fbpc_known_flow");
  if (!$flow) {
    $flow = $storage->create(["id" => "fbpc_known_flow", "label" => "FBPC known flow", "plugin" => "multistep_default"]);
  }
  $flow->set("configuration", [
    "panes" => [
      "login" => ["step" => "login", "weight" => 0],
      "facebook_checkout" => ["step" => "order_information", "weight" => 1],
      "review" => ["step" => "review", "weight" => 2],
      "completion_message" => ["step" => "complete", "weight" => 3],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fbpc_known_flow runs facebook_checkout on order_information; default flow has it _disabled"

#!/usr/bin/env bash
# Introspection CLEANUP: remove the facebook_checkout pane from the default checkout flow.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  if ($flow) {
    $config = $flow->get("configuration");
    unset($config["panes"]["facebook_checkout"]);
    $flow->set("configuration", $config)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facebook_checkout pane removed from commerce_checkout_flow default"

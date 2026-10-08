#!/usr/bin/env bash
# Execution CLEANUP: same as the reset - drop the pane from the default checkout flow.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  if ($flow) {
    $c = $flow->get("configuration");
    unset($c["panes"]["facebook_checkout"]);
    $flow->set("configuration", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facebook_checkout pane removed from commerce_checkout_flow default"

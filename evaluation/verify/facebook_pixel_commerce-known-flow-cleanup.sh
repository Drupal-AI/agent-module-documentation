#!/usr/bin/env bash
# Introspection CLEANUP: delete the fbpc_known_flow checkout flow and make sure the default
# flow has no facebook_checkout pane. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow");
  if ($flow = $storage->load("fbpc_known_flow")) { $flow->delete(); }
  if ($default = $storage->load("default")) {
    $c = $default->get("configuration");
    unset($c["panes"]["facebook_checkout"]);
    $default->set("configuration", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fbpc_known_flow deleted, default flow has no facebook_checkout pane"

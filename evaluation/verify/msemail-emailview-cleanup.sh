#!/usr/bin/env bash
# Execution CLEANUP (message_subscribe_email): restore subscribe_node's email baseline View. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node");
  $f->setThirdPartySetting("message_subscribe_ui", "view_name", "subscribe_node_email:default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: subscribe_node view_name restored to subscribe_node_email:default"

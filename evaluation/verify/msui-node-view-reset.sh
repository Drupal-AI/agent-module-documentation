#!/usr/bin/env bash
# Execution RESET (message_subscribe_ui): set subscribe_node's UI View to the email baseline
# (subscribe_node_email:default) so verify FAILS until the agent repoints it to the base
# subscribe_node view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node");
  $f->setThirdPartySetting("message_subscribe_ui", "view_name", "subscribe_node_email:default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: subscribe_node view_name = subscribe_node_email:default"

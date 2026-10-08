#!/usr/bin/env bash
# Execution RESET (message_subscribe_email): point subscribe_node's UI View at the NON-email base
# view (subscribe_node:default) so verify FAILS until the agent switches it to the email-aware view.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node");
  $f->setThirdPartySetting("message_subscribe_ui", "view_name", "subscribe_node:default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: subscribe_node view_name = subscribe_node:default"

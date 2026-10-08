#!/usr/bin/env bash
# Introspection SETUP (message_subscribe_ui): set the subscribe_term flag's subscription-UI View
# (third-party setting message_subscribe_ui.view_name) to a known value so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_term");
  $f->setThirdPartySetting("message_subscribe_ui", "view_name", "subscribe_taxonomy_term:default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: subscribe_term message_subscribe_ui.view_name = subscribe_taxonomy_term:default"

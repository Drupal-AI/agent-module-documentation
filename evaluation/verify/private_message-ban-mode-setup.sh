#!/usr/bin/env bash
# Introspection SETUP: set private_message.settings ban_mode to 'active' (default is 'passive')
# and a namespaced ban_message, so an inspecting agent can read the live blocking mode.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("private_message.settings");
  $c->set("ban_mode", "active")->set("ban_message", "PM_EVAL blocked notice")->save();
' >/dev/null 2>&1
echo "setup: private_message.settings ban_mode=active"

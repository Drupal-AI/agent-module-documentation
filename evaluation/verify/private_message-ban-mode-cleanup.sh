#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults for ban_mode ('passive') and ban_message.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("private_message.settings");
  $c->set("ban_mode", "passive")->set("ban_message", "User is unable to receive your message")->save();
' >/dev/null 2>&1
echo "cleanup: private_message.settings ban_mode restored to passive"

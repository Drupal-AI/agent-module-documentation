#!/usr/bin/env bash
# Introspection SETUP: set a known Shared Email warning message so an agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_msg", "SHAREDEMAIL_KNOWN_MSG_7F3 This address is shared.")->save();
' >/dev/null 2>&1
echo "setup: sharedemail.settings.sharedemail_msg set to known sentinel"

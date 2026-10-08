#!/usr/bin/env bash
# Introspection SETUP: set a known Shared Email allowlist so an agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_allowed", "vip-sharedemail@example.com")->save();
' >/dev/null 2>&1
echo "setup: sharedemail.settings.sharedemail_allowed = vip-sharedemail@example.com"

#!/usr/bin/env bash
# Introspection SETUP: set the global external_link_popup whitelist to a known trusted domain
# so an inspecting agent can read which domains are exempt from pop-ups. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("external_link_popup.settings")
    ->set("whitelist", "trusted-partner.test")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: external_link_popup.settings whitelist = trusted-partner.test"

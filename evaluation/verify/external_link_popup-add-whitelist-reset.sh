#!/usr/bin/env bash
# Execution RESET: clear the global external_link_popup whitelist (shipped default), so verify
# FAILS until the agent adds the trusted domain. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("external_link_popup.settings")->set("whitelist", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: external_link_popup.settings whitelist cleared"

#!/usr/bin/env bash
# Execution RESET: force the global link-alter flag OFF (noopener_filter.settings:filter_links=0)
# so verify FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noopener_filter.settings")->set("filter_links", 0)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: noopener_filter.settings:filter_links = 0"

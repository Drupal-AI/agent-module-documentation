#!/usr/bin/env bash
# Execution RESET: ensure enable_scroll=true (default) so verify FAILS until the agent disables it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ajax_comments.settings")->set("enable_scroll", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ajax_comments enable_scroll=true"

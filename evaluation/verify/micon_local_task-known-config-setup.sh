#!/usr/bin/env bash
# Introspection SETUP: set micon_local_task icon_only = true (non-default) so an agent can read
# it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("micon_local_task.config")->set("icon_only", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: micon_local_task.config icon_only=true"

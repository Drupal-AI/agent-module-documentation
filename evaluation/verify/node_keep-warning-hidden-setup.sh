#!/usr/bin/env bash
# Introspection SETUP: set node_keep.settings.hide_warning_messages=TRUE so the agent can read
# that the limited-access warning is hidden. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("node_keep.settings")->set("hide_warning_messages", TRUE)->save();' >/dev/null 2>&1
echo "setup: node_keep.settings hide_warning_messages=TRUE"

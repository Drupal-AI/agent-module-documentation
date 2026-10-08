#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (warning shown => hide_warning_messages FALSE).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("node_keep.settings")->set("hide_warning_messages", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: node_keep.settings hide_warning_messages=FALSE (default)"

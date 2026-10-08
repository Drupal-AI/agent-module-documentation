#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (empty) for url_patterns_to_ignore.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("url_patterns_to_ignore", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: quicklink.settings url_patterns_to_ignore restored to ''"

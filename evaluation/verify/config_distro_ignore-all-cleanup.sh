#!/usr/bin/env bash
# Introspection CLEANUP: restore all_collections to the shipped default (empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_ignore.settings")->set("all_collections", [])->save();' >/dev/null 2>&1
echo "cleanup: config_distro_ignore.settings all_collections restored to empty"

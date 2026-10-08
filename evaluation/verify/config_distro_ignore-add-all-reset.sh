#!/usr/bin/env bash
# Execution RESET: clear config_distro_ignore.settings all_collections so verify FAILS until the
# agent adds config_distro_eval.keepme to the ignore list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_ignore.settings")->set("all_collections", [])->save();' >/dev/null 2>&1
echo "reset: config_distro_ignore.settings all_collections cleared"

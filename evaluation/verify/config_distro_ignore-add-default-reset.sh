#!/usr/bin/env bash
# Execution RESET: clear config_distro_ignore.settings default_collection so verify FAILS until
# the agent adds config_distro_eval.dckeep to it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_ignore.settings")->set("default_collection", [])->save();' >/dev/null 2>&1
echo "reset: config_distro_ignore.settings default_collection cleared"

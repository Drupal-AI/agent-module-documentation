#!/usr/bin/env bash
# Introspection SETUP: add a known config name to config_distro_ignore.settings default_collection
# so the agent can report which config is ignored for the default collection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_ignore.settings")->set("default_collection", ["config_distro_eval.dc"])->save();' >/dev/null 2>&1
echo "setup: config_distro_ignore.settings default_collection = [config_distro_eval.dc]"

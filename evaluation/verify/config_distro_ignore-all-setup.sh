#!/usr/bin/env bash
# Introspection SETUP: add a known config name to config_distro_ignore.settings all_collections so
# the agent can inspect the live settings and report which config is permanently retained/ignored.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_ignore.settings")->set("all_collections", ["config_distro_eval.ignored"])->save();' >/dev/null 2>&1
echo "setup: config_distro_ignore.settings all_collections = [config_distro_eval.ignored]"

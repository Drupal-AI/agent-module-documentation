#!/usr/bin/env bash
# Introspection SETUP: mark node:article and node:page eligible for Smart Title in config, so
# the agent can read back the eligible bundle list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", ["node:article","node:page"])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: smart_title.settings.smart_title = [node:article, node:page]"

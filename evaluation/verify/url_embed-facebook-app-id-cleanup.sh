#!/usr/bin/env bash
# Introspection CLEANUP: delete url_embed.settings entirely, restoring baseline (the config
# object does not exist by default — the module ships no config/install file for it).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("url_embed.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: url_embed.settings deleted (restored to unset baseline)"

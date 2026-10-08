#!/usr/bin/env bash
# Introspection CLEANUP: restore key_auth.settings to its SHIPPED DEFAULTS
# (config/install/key_auth.settings.yml). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("key_auth.settings")
    ->set("auto_generate_keys", TRUE)
    ->set("key_length", 32)
    ->set("param_name", "api-key")
    ->set("detection_methods", ["header", "query"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: key_auth.settings restored to shipped defaults"

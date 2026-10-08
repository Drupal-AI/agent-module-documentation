#!/usr/bin/env bash
# Execution RESET: force key_auth.settings back to its SHIPPED DEFAULTS (param_name
# 'api-key', detection_methods [header, query]), which fails the target config
# (param_name 'api-token', detection_methods [header] only) so verify FAILS on baseline.
# Idempotent. Exit 0.
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
echo "reset: key_auth.settings forced to shipped defaults (param_name=api-key, detection_methods=[header,query])"

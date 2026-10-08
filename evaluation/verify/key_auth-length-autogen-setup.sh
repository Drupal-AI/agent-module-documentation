#!/usr/bin/env bash
# Introspection SETUP: write a second KNOWN non-default key_auth.settings configuration
# (distinct from key_auth-param-detection) so an inspecting agent must read the live config
# to answer (key length + auto_generate_keys). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("key_auth.settings")
    ->set("auto_generate_keys", FALSE)
    ->set("key_length", 16)
    ->set("param_name", "auth-secret")
    ->set("detection_methods", ["query"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: key_auth.settings -> key_length=16, auto_generate_keys=false, param_name=auth-secret, detection_methods=[query]"

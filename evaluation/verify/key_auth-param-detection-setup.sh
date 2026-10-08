#!/usr/bin/env bash
# Introspection SETUP: write a KNOWN non-default key_auth.settings configuration so an
# inspecting agent must read the live config to answer (param name + detection methods).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("key_auth.settings")
    ->set("auto_generate_keys", FALSE)
    ->set("key_length", 48)
    ->set("param_name", "x-ka-token")
    ->set("detection_methods", ["header"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: key_auth.settings -> param_name=x-ka-token, detection_methods=[header], key_length=48, auto_generate_keys=false"

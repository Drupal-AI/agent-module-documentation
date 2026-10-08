#!/usr/bin/env bash
# Introspection SETUP: configure a default API application that uses the API-key method
# (authentication_method=1) so an agent can read which method the default app uses. Local
# config only (no external auth). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_api_authentication.settings")
    ->set("applications", ["app-eval-1" => ["name" => "Eval App", "authentication_method" => 1, "is_default" => TRUE]])
    ->set("default_application_id", "app-eval-1")
    ->save();
' >/dev/null 2>&1
echo "setup: default application app-eval-1 uses authentication_method=1 (api_key)"

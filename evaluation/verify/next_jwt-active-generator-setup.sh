#!/usr/bin/env bash
# next_jwt introspection SETUP: set the active preview URL generator to jwt.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("next.settings")
    ->set("preview_url_generator", "jwt")
    ->set("preview_url_generator_configuration", ["secret_expiration" => 30, "access_token_expiration" => 300])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: next.settings.preview_url_generator=jwt"

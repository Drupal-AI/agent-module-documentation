#!/usr/bin/env bash
# next_jwt execution CLEANUP: restore default preview URL generator (simple_oauth).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("next.settings")
    ->set("preview_url_generator", "simple_oauth")
    ->set("preview_url_generator_configuration", ["secret_expiration" => 30])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: next.settings.preview_url_generator restored to simple_oauth"

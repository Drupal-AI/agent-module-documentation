#!/usr/bin/env bash
# next_jwt execution RESET: force preview_url_generator=simple_oauth so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("next.settings")
    ->set("preview_url_generator", "simple_oauth")
    ->set("preview_url_generator_configuration", ["secret_expiration" => 30])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: next.settings.preview_url_generator=simple_oauth"

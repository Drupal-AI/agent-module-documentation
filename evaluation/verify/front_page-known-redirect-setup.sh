#!/usr/bin/env bash
# Introspection SETUP: enable Front Page override and set the anonymous role to redirect to
# /user/login, so the agent can read the configured redirect path from front_page.settings.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("front_page.settings")
    ->set("enabled", TRUE)
    ->set("roles.anonymous", ["enabled" => TRUE, "weight" => 0, "path" => "/user/login"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: front_page enabled; anonymous -> /user/login"

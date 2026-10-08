#!/usr/bin/env bash
# Introspection SETUP: enable the "redirect logged-in users to their profile" common setting so an
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("multiple_registration.common_settings_page_form_config")->set("enable_redirect_to_user_profile_when_user_logged_in", 1)->save();' >/dev/null 2>&1
echo "setup: enable_redirect_to_user_profile_when_user_logged_in = 1"

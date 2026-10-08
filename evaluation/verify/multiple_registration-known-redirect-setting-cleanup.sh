#!/usr/bin/env bash
# Introspection CLEANUP: restore the redirect common setting to shipped default (0). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("multiple_registration.common_settings_page_form_config")->set("enable_redirect_to_user_profile_when_user_logged_in", 0)->save();' >/dev/null 2>&1
echo "cleanup: enable_redirect_to_user_profile_when_user_logged_in = 0"

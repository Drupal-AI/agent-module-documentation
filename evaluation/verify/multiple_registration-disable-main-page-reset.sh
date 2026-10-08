#!/usr/bin/env bash
# Execution RESET: force multiple_registration.common_settings_page_form_config
# multiple_registration_disable_main = 0 (main /user/register enabled) so verify FAILS until the
# agent disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("multiple_registration.common_settings_page_form_config")->set("multiple_registration_disable_main", 0)->save();' >/dev/null 2>&1
echo "reset: multiple_registration_disable_main = 0"

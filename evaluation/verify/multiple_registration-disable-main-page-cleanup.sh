#!/usr/bin/env bash
# Execution CLEANUP: restore multiple_registration_disable_main to shipped default 0. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("multiple_registration.common_settings_page_form_config")->set("multiple_registration_disable_main", 0)->save();' >/dev/null 2>&1
echo "cleanup: multiple_registration_disable_main = 0"

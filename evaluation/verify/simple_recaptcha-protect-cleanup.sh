#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_recaptcha.config")->set("form_ids","user_pass,user_register_form")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: form_ids restored to defaults"

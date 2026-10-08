#!/usr/bin/env bash
# Execution RESET: set form_ids to defaults WITHOUT user_login_form, v2, so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_recaptcha.config")->set("form_ids","user_pass,user_register_form")->set("recaptcha_type","v2")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: simple_recaptcha.config form_ids has no user_login_form"

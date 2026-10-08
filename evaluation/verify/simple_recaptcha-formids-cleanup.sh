#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_recaptcha.config")->set("form_ids","user_pass,user_register_form")->set("recaptcha_type","v2")->set("v3_score",80)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: simple_recaptcha.config restored to defaults"

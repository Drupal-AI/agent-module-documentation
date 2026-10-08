#!/usr/bin/env bash
# Introspection SETUP: set a known protected form-ID list + v2. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_recaptcha.config")->set("form_ids","user_login_form,contact_message_feedback,webform_submission_*")->set("recaptcha_type","v2")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: simple_recaptcha.config form_ids set, recaptcha_type=v2"

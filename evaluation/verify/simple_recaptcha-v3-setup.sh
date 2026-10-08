#!/usr/bin/env bash
# Introspection SETUP: switch to reCAPTCHA v3 with a known score threshold. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_recaptcha.config")->set("recaptcha_type","v3")->set("v3_score",65)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: simple_recaptcha.config recaptcha_type=v3 v3_score=65"

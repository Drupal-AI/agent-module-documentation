#!/usr/bin/env bash
# Introspection SETUP: configure API key authentication (auth_using=key) with a known email.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("cloudflare.settings");$c->set("auth_using","key")->set("apikey","cf_test_key_DEADBEEF")->set("email","cf-admin@example.com")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cloudflare auth_using=key, email cf-admin@example.com"

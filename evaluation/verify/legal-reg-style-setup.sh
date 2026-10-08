#!/usr/bin/env bash
# Introspection SETUP: set the registration T&C display style to 2 (HTML text) so an agent
# can read the configured style back.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("legal.settings")->set("registration_terms_style", 2)->save();' >/dev/null 2>&1
echo "setup: legal.settings registration_terms_style=2 (HTML text)"

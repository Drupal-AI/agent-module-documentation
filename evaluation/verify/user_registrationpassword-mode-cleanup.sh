#!/usr/bin/env bash
# Restore shipped default (registration=with-pass). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_registrationpassword.settings")->set("registration","with-pass")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user_registrationpassword registration restored to with-pass"

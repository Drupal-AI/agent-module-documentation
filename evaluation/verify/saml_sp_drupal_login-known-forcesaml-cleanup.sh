#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp_drupal_login.config")->set("force_saml_only", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: force_saml_only restored to FALSE"

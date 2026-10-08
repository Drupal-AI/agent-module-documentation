#!/usr/bin/env bash
# Restore shipped default '<front>'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp_drupal_login.config")->set("logged_in_redirect", "<front>")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: logged_in_redirect restored to <front>"

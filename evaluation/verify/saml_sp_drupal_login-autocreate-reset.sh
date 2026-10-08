#!/usr/bin/env bash
# Execution RESET: account_request_create_account OFF so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp_drupal_login.config")->set("account_request_create_account", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: account_request_create_account=FALSE"

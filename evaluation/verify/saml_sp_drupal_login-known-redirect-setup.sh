#!/usr/bin/env bash
# Introspection SETUP: set a known logged_in_redirect so the agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp_drupal_login.config")->set("logged_in_redirect", "/user/dashboard-smlsp")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: logged_in_redirect=/user/dashboard-smlsp"

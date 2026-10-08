#!/usr/bin/env bash
# Introspection SETUP: enable force_saml_only so the agent can inspect saml_sp_drupal_login.config
# and report that the Drupal login form is bypassed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp_drupal_login.config")->set("force_saml_only", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: saml_sp_drupal_login.config force_saml_only=TRUE"

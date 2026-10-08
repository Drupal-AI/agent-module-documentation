#!/usr/bin/env bash
# Introspection SETUP: set domain_path.settings.alias_title to 'hostname' so the agent can read
# how domains are labelled in the alias widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("domain_path.settings")->set("alias_title","hostname")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: domain_path.settings.alias_title = hostname"

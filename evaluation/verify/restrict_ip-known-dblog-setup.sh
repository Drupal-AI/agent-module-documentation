#!/usr/bin/env bash
# Introspection SETUP: enable logging of blocked attempts (dblog=true). Does NOT enable restriction.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("restrict_ip.settings"); $c->set("dblog",TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: restrict_ip.settings dblog=true"

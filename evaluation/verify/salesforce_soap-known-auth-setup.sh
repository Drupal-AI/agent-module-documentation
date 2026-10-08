#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("salesforce_auth_provider","soap_prod")->save();' >/dev/null 2>&1
echo "setup: salesforce_auth_provider=soap_prod (auth used by the SOAP client)"

#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en salesforce_soap -y >/dev/null 2>&1 || true
echo "setup: salesforce_soap enabled; salesforce.soap_client service present"

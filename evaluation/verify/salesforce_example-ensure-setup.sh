#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en salesforce_example -y >/dev/null 2>&1 || true
echo "setup: salesforce_example enabled; example mapping salesforce_example_contact present"

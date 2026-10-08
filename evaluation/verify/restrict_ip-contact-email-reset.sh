#!/usr/bin/env bash
# Execution RESET: clear mail_address and dblog so verify FAILS. Does NOT enable restriction.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("restrict_ip.settings"); $c->set("mail_address","")->set("dblog",FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mail_address empty, dblog false"

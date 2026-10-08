#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("restrict_ip.settings"); $c->set("mail_address","")->set("dblog",FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mail_address+dblog restored to defaults"

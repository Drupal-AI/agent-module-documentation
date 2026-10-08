#!/usr/bin/env bash
# Restore shipped default accept_every_login=FALSE.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("legal.settings")->set("accept_every_login", FALSE)->save();' >/dev/null 2>&1
echo "baseline: legal.settings accept_every_login=FALSE"

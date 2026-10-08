#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($t=\Drupal\registration\Entity\RegistrationType::load("reg_wl")){$t->delete();}' >/dev/null 2>&1
echo "cleanup: registration.type.reg_wl removed"

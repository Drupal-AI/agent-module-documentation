#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en migrate_plus -y >/dev/null 2>&1
drush php:eval 'use Drupal\migrate_plus\Entity\Migration; if (Migration::load("mdd8_users")) { Migration::load("mdd8_users")->delete(); }' >/dev/null 2>&1
echo "reset: migrate_plus enabled; migration mdd8_users absent"

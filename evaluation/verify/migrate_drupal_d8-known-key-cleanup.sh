#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\migrate_plus\Entity\Migration; if (Migration::load("mdd8_key")) { Migration::load("mdd8_key")->delete(); }' >/dev/null 2>&1
echo "cleanup: migration mdd8_key removed"

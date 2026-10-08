#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k = Key::load("ee_api_key")) { $k->delete(); }' >/dev/null 2>&1
echo "cleanup: Key ee_api_key removed"

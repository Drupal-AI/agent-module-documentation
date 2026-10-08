#!/usr/bin/env bash
# Introspection CLEANUP: delete Key entity azure_api_known. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k = Key::load("azure_api_known")) { $k->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Key entity azure_api_known removed"

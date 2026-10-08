#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("config.storage")->delete("views.view.vttnii_known");' >/dev/null 2>&1
echo "cleanup: view vttnii_known removed"

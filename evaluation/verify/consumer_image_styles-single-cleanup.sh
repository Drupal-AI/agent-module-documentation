#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id"=>"cis_medium"]) as $e) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: consumer cis_medium removed"

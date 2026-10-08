#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Server; if($s=Server::load("sao_new")){$s->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: search_api.server sao_new removed"

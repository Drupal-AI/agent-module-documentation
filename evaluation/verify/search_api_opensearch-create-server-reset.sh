#!/usr/bin/env bash
# Execution RESET: ensure server sao_new does NOT exist, so verify FAILS until the agent creates
# an OpenSearch-backed Search API server named sao_new with a standard connector.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Server; if($s=Server::load("sao_new")){$s->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api.server sao_new absent"

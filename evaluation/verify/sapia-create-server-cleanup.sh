#!/usr/bin/env bash
# Execution CLEANUP: delete sapia_server. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Server; if ($s = Server::load("sapia_server")) { $s->delete(); }' >/dev/null 2>&1
echo "cleanup: server sapia_server removed"

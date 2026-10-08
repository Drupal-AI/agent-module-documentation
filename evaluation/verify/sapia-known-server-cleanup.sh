#!/usr/bin/env bash
# Introspection CLEANUP: delete the sapia_known server. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Server; if ($s = Server::load("sapia_known")) { $s->delete(); }' >/dev/null 2>&1
echo "cleanup: server sapia_known removed"

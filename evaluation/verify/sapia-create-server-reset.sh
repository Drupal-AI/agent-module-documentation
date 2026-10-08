#!/usr/bin/env bash
# Execution RESET: ensure server sapia_server does NOT exist, so verify FAILS until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Server; if ($s = Server::load("sapia_server")) { $s->delete(); }' >/dev/null 2>&1
echo "reset: server sapia_server absent"

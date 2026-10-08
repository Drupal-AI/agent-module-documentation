#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("drd_agent.authorised");' >/dev/null 2>&1
echo "cleanup: drd_agent.authorised State key removed"

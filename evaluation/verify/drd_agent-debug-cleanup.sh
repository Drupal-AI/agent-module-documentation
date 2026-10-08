#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("drd_agent.debug_mode");' >/dev/null 2>&1
echo "cleanup: drd_agent.debug_mode State key removed"

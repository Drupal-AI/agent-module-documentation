#!/usr/bin/env bash
# Execution CLEANUP: unban the target IP. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("ban.ip_manager")->unbanIp("198.51.100.42");' >/dev/null 2>&1
echo "cleanup: IP 198.51.100.42 unbanned"

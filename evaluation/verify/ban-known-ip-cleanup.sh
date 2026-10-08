#!/usr/bin/env bash
# Introspection CLEANUP: unban the known IP. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("ban.ip_manager")->unbanIp("203.0.113.77");' >/dev/null 2>&1
echo "cleanup: IP 203.0.113.77 unbanned"

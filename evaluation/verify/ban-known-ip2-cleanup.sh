#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("ban.ip_manager")->unbanIp("192.0.2.55");' >/dev/null 2>&1
echo "cleanup: IP 192.0.2.55 unbanned"

#!/usr/bin/env bash
# Introspection CLEANUP: remove the 203.0.113.45 ban created by the matching setup.
# Restores baseline (no advban_ip row for that IP). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("advban.ip_manager")->unbanIp("203.0.113.45");
' >/dev/null 2>&1
echo "cleanup: 203.0.113.45 unbanned"

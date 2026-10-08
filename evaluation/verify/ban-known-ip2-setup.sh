#!/usr/bin/env bash
# Introspection SETUP: ban documentation IP 192.0.2.55 (TEST-NET-1).
set -uo pipefail
cd /var/www/html
drush php:eval '$m=\Drupal::service("ban.ip_manager"); if(!$m->isBanned("192.0.2.55")){$m->banIp("192.0.2.55");}' >/dev/null 2>&1
echo "setup: IP 192.0.2.55 banned"

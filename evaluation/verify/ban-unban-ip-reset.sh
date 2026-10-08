#!/usr/bin/env bash
# Execution RESET: ensure 192.0.2.99 IS banned, so verify (which passes when it is NOT banned) FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '$m=\Drupal::service("ban.ip_manager"); if(!$m->isBanned("192.0.2.99")){$m->banIp("192.0.2.99");}' >/dev/null 2>&1
echo "reset: IP 192.0.2.99 is banned"

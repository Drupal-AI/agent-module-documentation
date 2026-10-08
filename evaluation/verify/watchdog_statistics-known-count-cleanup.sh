#!/usr/bin/env bash
# Introspection CLEANUP: remove the ws_eval watchdog rows created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("watchdog")->condition("type", "ws_eval")->execute();' >/dev/null 2>&1
echo "cleanup: ws_eval watchdog rows removed"

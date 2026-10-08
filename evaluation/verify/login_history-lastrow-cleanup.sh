#!/usr/bin/env bash
# Introspection CLEANUP: remove the seeded login_history row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("login_history")->condition("hostname", "198.51.100.42")->execute();' >/dev/null 2>&1
echo "cleanup: removed login_history rows with hostname 198.51.100.42"

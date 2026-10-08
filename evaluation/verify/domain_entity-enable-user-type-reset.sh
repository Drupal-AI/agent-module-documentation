#!/usr/bin/env bash
# Execution RESET: ensure the user entity type does NOT have domain access (delete only its own
# domain_access field storage) so verify FAILS until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("domain_entity.mapper")->deleteFieldStorage("user");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: user entity type has no domain_access storage"

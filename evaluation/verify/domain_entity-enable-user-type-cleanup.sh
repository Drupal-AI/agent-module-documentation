#!/usr/bin/env bash
# Execution CLEANUP: remove the user domain_access field storage created by the build, back to
# baseline. Deletes only that storage. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("domain_entity.mapper")->deleteFieldStorage("user");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user domain_access storage removed"

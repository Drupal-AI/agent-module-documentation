#!/usr/bin/env bash
# Introspection CLEANUP: disable domain access on taxonomy_term by deleting ONLY the
# domain_access field storage this fixture created (never a broad field sweep). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("domain_entity.mapper")->deleteFieldStorage("taxonomy_term");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: domain_access removed from taxonomy_term"

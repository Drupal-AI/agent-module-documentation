#!/usr/bin/env bash
# Introspection SETUP: enable domain_entity domain access on taxonomy_term (create its
# domain_access field storage) so an agent can read back which types are enabled. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("domain_entity.mapper")->createFieldStorage("taxonomy_term");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: domain_access enabled on taxonomy_term"

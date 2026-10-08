#!/usr/bin/env bash
# MEDIUM (introspection) cleanup: restore the amazee.ai VectorDB Postgres config keys to
# their config/install defaults (empty host/db/user, port 5432).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_provider_amazeeio.settings")
    ->set("postgres_host", "")
    ->set("postgres_port", 5432)
    ->set("postgres_default_database", "")
    ->set("postgres_username", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_provider_amazeeio VectorDB Postgres config restored to defaults"

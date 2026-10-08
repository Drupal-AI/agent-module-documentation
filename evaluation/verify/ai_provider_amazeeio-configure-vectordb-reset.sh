#!/usr/bin/env bash
# HARD (execution) reset: clear the amazee.ai VectorDB Postgres connection keys in
# ai_provider_amazeeio.settings back to their install defaults so the task starts empty.
# The agent must then fill in the requested Postgres connection details.
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
echo "reset: ai_provider_amazeeio VectorDB Postgres config cleared to baseline"

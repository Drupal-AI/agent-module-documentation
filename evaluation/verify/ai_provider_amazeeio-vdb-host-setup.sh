#!/usr/bin/env bash
# MEDIUM (introspection) setup: write a KNOWN amazee.ai VectorDB Postgres config into
# ai_provider_amazeeio.settings so an agent can read it back off the live site.
# Restored by the matching -cleanup script. No amazee.ai API call is made.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_provider_amazeeio.settings")
    ->set("postgres_host", "vdb.eval.amazee.internal")
    ->set("postgres_port", 6543)
    ->set("postgres_default_database", "eval_vectors")
    ->set("postgres_username", "eval_reader")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_provider_amazeeio VectorDB Postgres config set to known values"

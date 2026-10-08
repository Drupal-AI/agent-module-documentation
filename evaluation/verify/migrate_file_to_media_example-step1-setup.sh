#!/usr/bin/env bash
# Introspection SETUP: ensure the example module's shipped migrations are present/discoverable so an
# inspecting agent can read the step-1 migration config. The migrations ship as config, so this
# just rebuilds caches. Idempotent.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
present=$(drush php:eval 'print \Drupal::config("migrate_plus.migration.migrate_file_to_media_example_article_images_step1")->get("source.plugin") ?? "none";' 2>/dev/null)
echo "setup: example step1 migration source.plugin=${present}"

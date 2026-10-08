#!/usr/bin/env bash
# Introspection CLEANUP: remove the probe mapping row(s). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("migrate_file_to_media_mapping")->condition("migration_id","mf2m_probe_mapping")->execute();' >/dev/null 2>&1
echo "cleanup: mf2m_probe_mapping rows removed"

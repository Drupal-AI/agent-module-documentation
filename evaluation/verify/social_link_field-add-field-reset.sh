#!/usr/bin/env bash
# Execution RESET: ensure Article has NO field_slf_task, so verify FAILS until the agent adds a
# social_links field named field_slf_task to the Article content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_slf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_slf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_slf_task absent from Article"

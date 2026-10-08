#!/usr/bin/env bash
# Execution RESET: ensure Article has NO field_ert_task (verify FAILS until the agent adds it).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ert_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ert_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ert_task absent"

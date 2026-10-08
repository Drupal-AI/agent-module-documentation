#!/usr/bin/env bash
# Execution RESET for "add a contextual-override media field": ensure Article has NO
# field_mlmm_task, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mlmm_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mlmm_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_mlmm_task absent from node.article"

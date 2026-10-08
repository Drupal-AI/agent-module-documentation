#!/usr/bin/env bash
# Execution RESET: ensure Article has NO field_dtn_period, so verify FAILS until the agent
# adds a Datetime Range field with the daterange_default widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dtn_period")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dtn_period")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_dtn_period absent from node.article"

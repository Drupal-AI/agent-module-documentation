#!/usr/bin/env bash
# Execution RESET: ensure there is NO link_description field field_ld_task on Article, so verify
# FAILS until the agent creates it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ld_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ld_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_ld_task absent on node.article"

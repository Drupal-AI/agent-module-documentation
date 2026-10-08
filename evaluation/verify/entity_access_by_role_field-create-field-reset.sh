#!/usr/bin/env bash
# Execution RESET: ensure field_eabrf_new does NOT exist on Article, so verify FAILS until the
# agent creates an entity_access_by_role_field field named field_eabrf_new on Article.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_eabrf_new")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_eabrf_new")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eabrf_new absent on node.article"

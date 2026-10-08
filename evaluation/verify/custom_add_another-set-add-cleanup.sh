#!/usr/bin/env bash
# Execution CLEANUP: remove field_caa_add and the caa_add content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","caa_add","field_caa_add")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_caa_add")) { $fs->delete(); }
  if ($t = NodeType::load("caa_add")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: caa_add + field_caa_add removed"

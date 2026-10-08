#!/usr/bin/env bash
# Execution CLEANUP: remove field_mask_task and the mask_ct content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","mask_ct","field_mask_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_mask_task")) { $fs->delete(); }
  if ($t = NodeType::load("mask_ct")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mask_task + mask_ct removed"

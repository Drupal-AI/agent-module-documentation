#!/usr/bin/env bash
# Introspection CLEANUP: remove field_mask_known and the mask_ct content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","mask_ct","field_mask_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_mask_known")) { $fs->delete(); }
  if ($t = NodeType::load("mask_ct")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mask_known + mask_ct removed"

#!/usr/bin/env bash
# Introspection CLEANUP: remove field_caa_lbl and the caa_known content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","caa_known","field_caa_lbl")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_caa_lbl")) { $fs->delete(); }
  if ($t = NodeType::load("caa_known")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: caa_known + field_caa_lbl removed"

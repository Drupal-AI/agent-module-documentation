#!/usr/bin/env bash
# Execution CLEANUP: remove field_caa_rm and the caa_rm content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","caa_rm","field_caa_rm")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_caa_rm")) { $fs->delete(); }
  if ($t = NodeType::load("caa_rm")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: caa_rm + field_caa_rm removed"

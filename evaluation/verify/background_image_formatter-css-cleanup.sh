#!/usr/bin/env bash
# Execution CLEANUP: remove field_bif_task and the bif_task content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","bif_task","field_bif_task")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_bif_task")) $fs->delete();
  if ($nt=NodeType::load("bif_task")) $nt->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bif_task and field_bif_task removed"

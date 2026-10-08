#!/usr/bin/env bash
# Execution CLEANUP: remove field_bif_link and the bif_task2 content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","bif_task2","field_bif_link")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_bif_link")) $fs->delete();
  if ($nt=NodeType::load("bif_task2")) $nt->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bif_task2 and field_bif_link removed"

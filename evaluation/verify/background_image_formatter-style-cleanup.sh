#!/usr/bin/env bash
# Introspection CLEANUP: remove field_bif_style and the bif_stylect content type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","bif_stylect","field_bif_style")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_bif_style")) $fs->delete();
  if ($nt=NodeType::load("bif_stylect")) $nt->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bif_stylect and field_bif_style removed"

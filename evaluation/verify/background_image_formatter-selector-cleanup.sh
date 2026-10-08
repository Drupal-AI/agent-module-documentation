#!/usr/bin/env bash
# Introspection CLEANUP: remove field_bif_hero and the bif_selct content type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","bif_selct","field_bif_hero")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_bif_hero")) $fs->delete();
  if ($nt=NodeType::load("bif_selct")) $nt->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bif_selct and field_bif_hero removed"

#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd->getComponent("field_ecfri_pic")) { $vd->removeComponent("field_ecfri_pic")->save(); }
  if ($fc=FieldConfig::loadByName("node","article","field_ecfri_pic")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_ecfri_pic")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_ecfri_pic removed"

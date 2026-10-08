#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) { $vd->removeComponent("field_rilf_img")->save(); }
  foreach (["field_rilf_img", "field_rilf_link"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_rilf_img/field_rilf_link removed from node.article"

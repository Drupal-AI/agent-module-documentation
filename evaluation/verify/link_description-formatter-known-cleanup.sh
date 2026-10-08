#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ld_disp2 and its (possibly stale) display component. Baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ld_disp2")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ld_disp2")) { $fs->delete(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_ld_disp2")) { $vd->removeComponent("field_ld_disp2")->save(); }
' >/dev/null 2>&1
echo "cleanup: field_ld_disp2 removed from node.article"

#!/usr/bin/env bash
# Execution CLEANUP: remove field_ld_disp from Article and explicitly drop its (possibly stale)
# view-display component so no orphaned formatter config lingers. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ld_disp")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ld_disp")) { $fs->delete(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_ld_disp")) { $vd->removeComponent("field_ld_disp")->save(); }
' >/dev/null 2>&1
echo "cleanup: field_ld_disp removed from node.article (component dropped)"

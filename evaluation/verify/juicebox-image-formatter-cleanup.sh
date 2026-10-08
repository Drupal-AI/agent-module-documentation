#!/usr/bin/env bash
# Introspection CLEANUP for Juicebox medium cases. Removes the probe image field added by
# the matching setup, restoring node.article to baseline. Deletes the display component,
# then field config, then storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_jb_probe")) { $vd->removeComponent("field_jb_probe")->save(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_jb_probe")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_jb_probe")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_jb_probe removed"

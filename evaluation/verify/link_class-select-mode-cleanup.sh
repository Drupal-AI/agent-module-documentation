#!/usr/bin/env bash
# Introspection CLEANUP: remove the known node.article field_lc_pick Link field (form-display
# component + field config + storage), restoring baseline (it does not ship by default).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd && $fd->getComponent("field_lc_pick")) { $fd->removeComponent("field_lc_pick")->save(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_lc_pick")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_lc_pick")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_lc_pick removed"

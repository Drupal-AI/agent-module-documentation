#!/usr/bin/env bash
# Introspection CLEANUP: remove the fgl_uri view mode, its display and the namespaced field
# created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if ($vd = $s->load("node.article.fgl_uri")) { $vd->delete(); }
  if ($m = EntityViewMode::load("node.fgl_uri")) { $m->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_fgl_promo_text")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fgl_promo_text")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.fgl_uri view mode/display and field_fgl_promo_text removed"

#!/usr/bin/env bash
# Execution CLEANUP: remove the fgl_teaser view mode, its display, the namespaced Article
# field created by the reset, and any leftover verify probe node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $ns = \Drupal::entityTypeManager()->getStorage("node")
    ->loadByProperties(["title" => "fgl teaser verify probe"]);
  foreach ($ns as $n) { $n->delete(); }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if ($vd = $s->load("node.article.fgl_teaser")) { $vd->delete(); }
  if ($m = EntityViewMode::load("node.fgl_teaser")) { $m->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_fgl_teaser_text")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fgl_teaser_text")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.fgl_teaser view mode/display, field_fgl_teaser_text and probe nodes removed"

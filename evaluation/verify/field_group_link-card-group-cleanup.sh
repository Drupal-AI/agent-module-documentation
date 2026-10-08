#!/usr/bin/env bash
# Execution CLEANUP: remove the fgl_task view mode, its display and the namespaced Article
# fields created by the reset. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if ($vd = $s->load("node.article.fgl_task")) { $vd->delete(); }
  if ($m = EntityViewMode::load("node.fgl_task")) { $m->delete(); }
  foreach (["field_fgl_task_link", "field_fgl_task_body"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.fgl_task view mode/display and field_fgl_task_* fields removed"

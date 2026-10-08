#!/usr/bin/env bash
# Introspection CLEANUP: disable Layout Builder on node.article and remove the layout_builder
# fields (layout_builder__translation, layout_builder__layout) to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")) {
    $d->disableLayoutBuilder()->setOverridable(FALSE)->save();
  }
  foreach (["layout_builder__translation","layout_builder__layout"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article LB disabled; layout_builder fields removed"

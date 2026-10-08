#!/usr/bin/env bash
# Introspection CLEANUP: delete the "BP Eval Carousel Page" node, its bp_carousel paragraph
# and nested bp_simple slides, and the field_bp_eval_carousel container field.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Eval Carousel Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) {
    foreach ($n->get("field_bp_eval_carousel") as $item) {
      if ($c = $item->entity) {
        foreach ($c->get("bp_slide_content") as $slide) {
          if ($slide->entity) { $slide->entity->delete(); }
        }
        $c->delete();
      }
    }
    $n->delete();
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bp_eval_carousel")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bp_eval_carousel")) { $fs->delete(); }
  // Purge the deleted field so its table is dropped now rather than at the next cron.
  field_purge_batch(200);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'BP Eval Carousel Page' node, its paragraphs and field_bp_eval_carousel removed"

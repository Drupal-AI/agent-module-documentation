#!/usr/bin/env bash
# Execution CLEANUP: delete the "BP Hard Uneven Page" node, its columns paragraph and nested
# children, and the field_bp_uneven_sections container field. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Hard Uneven Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) {
    foreach ($n->get("field_bp_uneven_sections") as $item) {
      if ($col = $item->entity) {
        if ($col->hasField("bp_column_content_2")) {
          foreach ($col->get("bp_column_content_2") as $child) {
            if ($child->entity) { $child->entity->delete(); }
          }
        }
        $col->delete();
      }
    }
    $n->delete();
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bp_uneven_sections")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bp_uneven_sections")) { $fs->delete(); }
  field_purge_batch(200);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'BP Hard Uneven Page' node, its paragraphs and field_bp_uneven_sections removed"

#!/usr/bin/env bash
# Execution CLEANUP: delete the "BP Hard Styled Page" node, any paragraphs it references, and
# the field_bp_hard_sections container field. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Hard Styled Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) {
    foreach ($n->get("field_bp_hard_sections") as $item) {
      if ($item->entity) { $item->entity->delete(); }
    }
    $n->delete();
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bp_hard_sections")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bp_hard_sections")) { $fs->delete(); }
  field_purge_batch(200);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'BP Hard Styled Page' node, its paragraphs and field_bp_hard_sections removed"

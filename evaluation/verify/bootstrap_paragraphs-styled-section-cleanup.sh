#!/usr/bin/env bash
# Introspection CLEANUP: delete the "BP Eval Styled Page" node, its bp_simple paragraph, and
# the field_bp_eval_styled container field. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Eval Styled Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) {
    foreach ($n->get("field_bp_eval_styled") as $item) {
      if ($item->entity) { $item->entity->delete(); }
    }
    $n->delete();
  }
  // Sweep any orphaned paragraphs left by an interrupted run.
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)
    ->condition("type", "bp_simple")->condition("bp_header", "Teal Section")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }

  if ($fc = FieldConfig::loadByName("node", "article", "field_bp_eval_styled")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bp_eval_styled")) { $fs->delete(); }
  // Purge the deleted field so its table is dropped now rather than at the next cron.
  field_purge_batch(200);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'BP Eval Styled Page' node, its paragraph and field_bp_eval_styled removed"

#!/usr/bin/env bash
# Introspection CLEANUP (bp_media): delete the styled node, its paragraph and
# field_bpmedia_styles. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Styled Section")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpmedia_styles")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpmedia_styles")) { $fs->delete(); }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\paragraphs\Entity\Paragraph;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_media")->condition("bp_header", "Styled Media Section")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
# Purge the just-deleted field data. Without this Drupal defers the purge and leaves a stale
# last-installed field storage definition behind, which makes later node deletes fail.
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
echo "cleanup: field_bpmedia_styles and 'BP Media Styled Section' removed"

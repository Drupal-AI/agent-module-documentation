#!/usr/bin/env bash
# Introspection CLEANUP (bp_media): delete the node, the bp_media paragraph, the media entity,
# its file and field_bpmedia_known. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\media\Entity\Media;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Known Section")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpmedia_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpmedia_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\media\Entity\Media;
  use Drupal\paragraphs\Entity\Paragraph;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_media")->condition("bp_header", "Known Media Section")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $mids = \Drupal::entityQuery("media")->accessCheck(FALSE)->condition("name", "BP Media Known Image")->execute();
  if ($mids) { \Drupal::entityTypeManager()->getStorage("media")->delete(Media::loadMultiple($mids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
# Purge the just-deleted field data. Without this Drupal defers the purge and leaves a stale
# last-installed field storage definition behind, which makes later node deletes fail.
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
echo "cleanup: field_bpmedia_known, its paragraph, node and media entity removed"

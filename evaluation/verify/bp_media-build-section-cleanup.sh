#!/usr/bin/env bash
# Execution CLEANUP (bp_media): remove the build-target node, its bp_media paragraphs,
# field_bpmedia_build and the media entity created by reset. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Build Target")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpmedia_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpmedia_build")) { $fs->delete(); }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\media\Entity\Media;
  use Drupal\paragraphs\Entity\Paragraph;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_media")->condition("bp_header", "Product Gallery")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $mids = \Drupal::entityQuery("media")->accessCheck(FALSE)->condition("name", "BP Media Build Image")->execute();
  if ($mids) { \Drupal::entityTypeManager()->getStorage("media")->delete(Media::loadMultiple($mids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
# Purge the just-deleted field data. Without this Drupal defers the purge and leaves a stale
# last-installed field storage definition behind, which makes later node deletes fail.
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
echo "cleanup: field_bpmedia_build, its paragraphs, node and build media entity removed"

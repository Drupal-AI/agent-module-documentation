#!/usr/bin/env bash
# Introspection CLEANUP (bp_callout): delete the node, its Callout paragraph and the
# field_bpcallout_known field created by the matching setup. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Callout Known Notice")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_callout")->condition("bp_header", "Known Callout")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpcallout_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpcallout_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\paragraphs\Entity\Paragraph;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_callout")->condition("bp_header", "Known Callout")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
' >/dev/null 2>&1
# Purge the just-deleted field data. Without this Drupal defers the purge and leaves a stale
# last-installed field storage definition behind, which makes later node deletes fail.
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
echo "cleanup: field_bpcallout_known and 'BP Callout Known Notice' removed"

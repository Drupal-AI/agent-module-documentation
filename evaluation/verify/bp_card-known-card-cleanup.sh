#!/usr/bin/env bash
# Introspection CLEANUP (bp_card): delete the node, its Card paragraph and field_bpcard_known.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Card Known Promo")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_card")->condition("bp_card_title", "Known Promo Card")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpcard_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpcard_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\paragraphs\Entity\Paragraph;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_card")->condition("bp_card_title", "Known Promo Card")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
' >/dev/null 2>&1
# Purge the just-deleted field data. Without this Drupal defers the purge and leaves a stale
# last-installed field storage definition behind, which makes later node deletes fail.
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
echo "cleanup: field_bpcard_known and 'BP Card Known Promo' removed"

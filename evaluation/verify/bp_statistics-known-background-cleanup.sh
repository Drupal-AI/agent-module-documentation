#!/usr/bin/env bash
# Introspection CLEANUP for bp_statistics: delete the background eval node (and its nested
# paragraphs) and the field_bpstat_b field created by the matching setup. Leaves the shipped
# bp_statistics and bp_stat paragraph types untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Statistics Background Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpstat_b")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpstat_b")) { $fs->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Statistics Background Node and field_bpstat_b removed"

#!/usr/bin/env bash
# Execution CLEANUP for bp_statistics "build a nested Statistics band": remove the task node
# (with its nested paragraphs) and the field_bpstat_task field created by the reset. Leaves
# the shipped bp_statistics / bp_stat paragraph types untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Statistics Task")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpstat_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpstat_task")) { $fs->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Statistics Task node and field_bpstat_task removed"

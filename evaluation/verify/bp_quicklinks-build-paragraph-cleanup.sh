#!/usr/bin/env bash
# Execution CLEANUP for bp_quicklinks "build a Quicklinks paragraph on a node": remove the
# task node and the field_bpquick_menu field created by the reset. Leaves the shipped
# bp_quicklinks paragraph type untouched. Idempotent. Exit 0.
#
# Node deletion and field deletion run as SEPARATE drush calls on purpose so a failure in
# one cannot skip the other.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Quicklinks Task")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpquick_menu")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpquick_menu")) { $fs->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Quicklinks Task node and field_bpquick_menu removed"

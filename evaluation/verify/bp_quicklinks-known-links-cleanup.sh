#!/usr/bin/env bash
# Introspection CLEANUP for bp_quicklinks: delete the eval node, its Quicklinks paragraph,
# and the field_bpquick_links field created by the matching setup. Leaves the shipped
# bp_quicklinks paragraph type untouched. Restores baseline. Idempotent. Exit 0.
#
# Node deletion and field deletion run as SEPARATE drush calls on purpose: if one fails
# (e.g. an unrelated stale field definition elsewhere on the site aborts an entity delete)
# the other still runs.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Quicklinks Eval Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpquick_links")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpquick_links")) { $fs->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Quicklinks Eval Node and field_bpquick_links removed"

#!/usr/bin/env bash
# Introspection CLEANUP: remove field_prepop_ref from Article (and its storage) plus the target
# node created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if ($fc = FieldConfig::loadByName("node", "article", "field_prepop_ref")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_prepop_ref")) { $fs->delete(); }
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "Prepopulate Eval Target")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_prepop_ref and the Prepopulate Eval Target node removed"
exit 0

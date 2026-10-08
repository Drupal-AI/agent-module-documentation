#!/usr/bin/env bash
# Execution CLEANUP: remove the field_defaults_hard2 node and the field_fd_over field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","field_defaults_hard2")->execute();
  foreach ($ids as $id) { if ($n = Node::load($id)) { $n->delete(); } }
  if ($fc = FieldConfig::loadByName("node","article","field_fd_over")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_fd_over")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_defaults_hard2 node and field_fd_over removed"

#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'Micon Medium Node' node and field_micon_val field.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"Micon Medium Node"]) as $n) { $n->delete(); }
  if ($fc = FieldConfig::loadByName("node","article","field_micon_val")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_micon_val")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Micon Medium Node + field_micon_val removed"

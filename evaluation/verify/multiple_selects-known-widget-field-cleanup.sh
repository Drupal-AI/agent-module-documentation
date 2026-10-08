#!/usr/bin/env bash
# Introspection CLEANUP: remove the field_msel_known field and the msel_ct content type
# created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if ($fc = FieldConfig::loadByName("node", "msel_ct", "field_msel_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_msel_known")) { $fs->delete(); }
  if ($nt = NodeType::load("msel_ct")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_msel_known and msel_ct content type removed"

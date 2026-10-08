#!/usr/bin/env bash
# Execution CLEANUP: remove the field_msel_conf field and the msel_ct content type created
# by the matching reset. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if ($fc = FieldConfig::loadByName("node", "msel_ct", "field_msel_conf")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_msel_conf")) { $fs->delete(); }
  if ($nt = NodeType::load("msel_ct")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_msel_conf and msel_ct content type removed"

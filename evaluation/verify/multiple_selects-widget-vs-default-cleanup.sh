#!/usr/bin/env bash
# Introspection CLEANUP: remove both fields (field_msel_multi, field_msel_single) and the
# msel_ct content type created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  foreach (["field_msel_multi", "field_msel_single"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "msel_ct", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
  if ($nt = NodeType::load("msel_ct")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_msel_multi, field_msel_single and msel_ct content type removed"

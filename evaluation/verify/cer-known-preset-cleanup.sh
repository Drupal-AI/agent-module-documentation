#!/usr/bin/env bash
# Introspection CLEANUP: delete the preset and the two fields created by the setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cer\Entity\CorrespondingReference;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($p = CorrespondingReference::load("cer_known")) { $p->delete(); }
  foreach (["field_cer_known_a", "field_cer_known_b"] as $name) {
    if ($fc = FieldConfig::loadByName("node", "article", $name)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $name)) { $fs->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: preset cer_known and fields field_cer_known_a/b removed"

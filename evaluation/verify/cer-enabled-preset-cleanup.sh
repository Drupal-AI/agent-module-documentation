#!/usr/bin/env bash
# Introspection CLEANUP: delete both presets and the two fields created by the setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cer\Entity\CorrespondingReference;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["cer_on", "cer_off"] as $id) {
    if ($p = CorrespondingReference::load($id)) { $p->delete(); }
  }
  foreach (["field_cer_sw_a", "field_cer_sw_b"] as $name) {
    if ($fc = FieldConfig::loadByName("node", "article", $name)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $name)) { $fs->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: presets cer_on/cer_off and fields field_cer_sw_a/b removed"

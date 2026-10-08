#!/usr/bin/env bash
# Introspection CLEANUP: remove both fields and the caa_onoff content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_caa_on","field_caa_off"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","caa_onoff",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
  if ($t = NodeType::load("caa_onoff")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: caa_onoff + field_caa_on/off removed"

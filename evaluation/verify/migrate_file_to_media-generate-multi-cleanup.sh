#!/usr/bin/env bash
# Execution CLEANUP: remove the mf2m_ht2 type and its fields. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_mf2m_a_media","field_mf2m_b_media","field_mf2m_a","field_mf2m_b"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","mf2m_ht2",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
  if ($t = NodeType::load("mf2m_ht2")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mf2m_ht2 and its fields removed"

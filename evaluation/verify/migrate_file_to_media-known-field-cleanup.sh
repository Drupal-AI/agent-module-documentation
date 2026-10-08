#!/usr/bin/env bash
# Introspection CLEANUP: remove the mf2m_kt type and its fields (source + generated media). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_mf2m_known_media","field_mf2m_known"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","mf2m_kt",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
  if ($t = NodeType::load("mf2m_kt")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mf2m_kt and its fields removed"

#!/usr/bin/env bash
# Execution CLEANUP: remove the mf2m_ht type and its fields. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_mf2m_task_media","field_mf2m_task"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","mf2m_ht",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
  if ($t = NodeType::load("mf2m_ht")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mf2m_ht and its fields removed"

#!/usr/bin/env bash
# Introspection CLEANUP: remove the ruftv_med content type and field_ruftv_med. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if($fc=FieldConfig::loadByName("node","ruftv_med","field_ruftv_med")) $fc->delete();
  if($fs=FieldStorageConfig::loadByName("node","field_ruftv_med")) $fs->delete();
  if($nt=NodeType::load("ruftv_med")) $nt->delete();
' >/dev/null 2>&1
echo "cleanup: node.ruftv_med and field_ruftv_med removed"

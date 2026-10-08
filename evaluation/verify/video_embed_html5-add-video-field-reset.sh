#!/usr/bin/env bash
# Execution RESET: ensure field_veh_video does NOT exist on Article, so verify FAILS until the
# agent creates it (restricted to html_5). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_veh_video")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_veh_video")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_veh_video absent on node.article"

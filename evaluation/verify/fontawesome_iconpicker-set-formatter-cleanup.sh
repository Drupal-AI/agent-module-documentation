#!/usr/bin/env bash
# Execution CLEANUP: remove field_faip_display. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_faip_display")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_faip_display")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_faip_display removed from node.article"

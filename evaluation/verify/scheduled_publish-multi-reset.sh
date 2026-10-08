#!/usr/bin/env bash
# Execution RESET: ensure NO field_spt2 exists on Article (so verify FAILS until built). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_spt2")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_spt2")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_spt2 absent"

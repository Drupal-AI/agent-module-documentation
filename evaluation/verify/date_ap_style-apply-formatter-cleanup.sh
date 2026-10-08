#!/usr/bin/env bash
# Execution CLEANUP: remove the probe field (drops its view-display component too). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_apstyle_probe")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_apstyle_probe")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_apstyle_probe removed from node.article"

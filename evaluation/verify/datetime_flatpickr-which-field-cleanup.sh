#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_dtf_fp","field_dtf_plain"] as $fn) { if ($f = FieldStorageConfig::loadByName("node",$fn)) { $f->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dtf_fp/field_dtf_plain removed"

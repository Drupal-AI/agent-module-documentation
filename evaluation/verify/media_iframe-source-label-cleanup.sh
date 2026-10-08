#!/usr/bin/env bash
# Introspection CLEANUP: remove mi_lblprobe and field_mi_lbl. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc=FieldConfig::loadByName("media","mi_lblprobe","field_mi_lbl")) { $fc->delete(); }
  \Drupal::configFactory()->getEditable("media.type.mi_lblprobe")->delete();
  if ($fs=FieldStorageConfig::loadByName("media","field_mi_lbl")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mi_lblprobe removed"

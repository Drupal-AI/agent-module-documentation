#!/usr/bin/env bash
# Introspection CLEANUP: remove media type mi_probe and its namespaced source field. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc=FieldConfig::loadByName("media","mi_probe","field_mi_probe")) { $fc->delete(); }
  \Drupal::configFactory()->getEditable("media.type.mi_probe")->delete();
  if ($fs=FieldStorageConfig::loadByName("media","field_mi_probe")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mi_probe removed"

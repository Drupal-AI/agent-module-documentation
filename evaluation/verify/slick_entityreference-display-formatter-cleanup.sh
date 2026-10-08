#!/usr/bin/env bash
# MEDIUM cleanup for slick_entityreference "which formatter" case: remove the display
# component and delete the throwaway field_ser_med field, restoring baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  if ($d->getComponent("field_ser_med")) { $d->removeComponent("field_ser_med")->save(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_ser_med")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_ser_med")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ser_med removed from node.article"

#!/usr/bin/env bash
# MEDIUM cleanup for slick_entityreference "which optionset" case: remove the display
# component, delete the throwaway field_ser_os field and the eval_er_carousel optionset.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  if ($d->getComponent("field_ser_os")) { $d->removeComponent("field_ser_os")->save(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_ser_os")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_ser_os")) { $fs->delete(); }
  if ($os = \Drupal\slick\Entity\Slick::load("eval_er_carousel")) { $os->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ser_os and eval_er_carousel optionset removed"

#!/usr/bin/env bash
# Execution RESET: delete media type mes_task and its field so verify FAILS until the agent
# creates a slideshow media type with an entity_reference source field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media","mes_task","field_mes_task")) { $fc->delete(); }
  if ($t = MediaType::load("mes_task")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_mes_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mes_task removed"

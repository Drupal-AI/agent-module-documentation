#!/usr/bin/env bash
# Introspection CLEANUP: remove media type mes_show and its field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media","mes_show","field_mes_show")) { $fc->delete(); }
  if ($t = MediaType::load("mes_show")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_mes_show")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mes_show removed"

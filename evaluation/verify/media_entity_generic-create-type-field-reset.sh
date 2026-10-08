#!/usr/bin/env bash
# Execution RESET: ensure media type meg_task2 and field field_meg_ref are absent. verify FAILS
# until agent creates meg_task2 with generic source whose source_field is field_meg_ref. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($t = MediaType::load("meg_task2")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_meg_ref")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: meg_task2 and field_meg_ref absent"

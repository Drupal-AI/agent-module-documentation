#!/usr/bin/env bash
# Execution reset: clear the section library to a known-empty baseline between eval runs so
# each hard case starts from nothing. Deletes every section_library_template content entity.
# (No config to restore — section_library.settings labels are left untouched.)
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("section_library_template");
  $all = $storage->loadMultiple();
  if ($all) { $storage->delete($all); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all section_library_template entities deleted"

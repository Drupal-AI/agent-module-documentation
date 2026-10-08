#!/usr/bin/env bash
# Introspection CLEANUP: clear the maximum upload size again (shipped value is empty, i.e.
# fall back to the PHP limit).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "document", "field_media_document");
  $s = $f->getSettings();
  $s["max_filesize"] = "";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: media document max_filesize cleared"

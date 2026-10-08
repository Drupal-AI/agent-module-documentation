#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped Document extension list.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "document", "field_media_document");
  $s = $f->getSettings();
  $s["file_extensions"] = "txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: media document file_extensions restored to the shipped list"

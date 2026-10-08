#!/usr/bin/env bash
# Execution RESET: restore the shipped (very broad) Document extension list so verify FAILS
# until the agent restricts it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "document", "field_media_document");
  $s = $f->getSettings();
  $s["file_extensions"] = "txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "reset: media document file_extensions restored to the shipped list"

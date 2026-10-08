#!/usr/bin/env bash
# Introspection SETUP: narrow the Document media type's source field to a known, distinctive
# allowed-extension list so the agent must read the live field config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "document", "field_media_document");
  $s = $f->getSettings();
  $s["file_extensions"] = "pdf docx csv";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "setup: media document field_media_document file_extensions='pdf docx csv'"

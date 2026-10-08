#!/usr/bin/env bash
# Introspection SETUP: set a known maximum upload size on the Document media type's source
# field so the agent must read the live field config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "document", "field_media_document");
  $s = $f->getSettings();
  $s["max_filesize"] = "7 MB";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "setup: media document field_media_document max_filesize='7 MB'"

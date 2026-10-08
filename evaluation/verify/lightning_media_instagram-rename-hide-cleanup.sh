#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped Instagram label and library default.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("instagram");
  $t->set("label", "Instagram")->save();
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "instagram", "field_media_in_library");
  $f->setDefaultValue([["value" => 1]])->save();
' >/dev/null 2>&1
echo "cleanup: instagram label and field_media_in_library default restored"

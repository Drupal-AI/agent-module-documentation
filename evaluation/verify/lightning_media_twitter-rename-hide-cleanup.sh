#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped Tweet label and library default.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("tweet");
  $t->set("label", "Tweet")->save();
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "tweet", "field_media_in_library");
  $f->setDefaultValue([["value" => 1]])->save();
' >/dev/null 2>&1
echo "cleanup: tweet label and field_media_in_library default restored"

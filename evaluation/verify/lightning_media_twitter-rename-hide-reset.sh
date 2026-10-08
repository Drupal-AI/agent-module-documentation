#!/usr/bin/env bash
# Execution RESET: restore the Tweet media type's shipped label and set its
# field_media_in_library default back to TRUE, so verify FAILS until the agent changes both.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("tweet");
  $t->set("label", "Tweet")->save();
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "tweet", "field_media_in_library");
  $f->setDefaultValue([["value" => 1]])->save();
' >/dev/null 2>&1
echo "reset: tweet label='Tweet', field_media_in_library default TRUE"

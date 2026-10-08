#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped label of the Tweet source field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "tweet", "embed_code");
  $f->set("label", "Tweet")->save();
' >/dev/null 2>&1
echo "cleanup: field.field.media.tweet.embed_code label restored to 'Tweet'"

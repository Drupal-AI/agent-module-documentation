#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped label of the Instagram source field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "instagram", "embed_code");
  $f->set("label", "Instagram post")->save();
' >/dev/null 2>&1
echo "cleanup: field.field.media.instagram.embed_code label restored to 'Instagram post'"

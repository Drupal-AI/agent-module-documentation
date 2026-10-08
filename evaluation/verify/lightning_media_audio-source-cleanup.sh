#!/usr/bin/env bash
# Introspection CLEANUP: restore the Audio media type's shipped label.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("audio");
  $t->set("label", "Audio")->save();
' >/dev/null 2>&1
echo "cleanup: media type audio label restored to 'Audio'"

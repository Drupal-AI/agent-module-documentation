#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped Tweet media type label.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("tweet");
  $t->set("label", "Tweet")->save();
' >/dev/null 2>&1
echo "cleanup: media type tweet label restored to 'Tweet'"

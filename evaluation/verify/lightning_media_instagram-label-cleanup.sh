#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped Instagram media type label.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("instagram");
  $t->set("label", "Instagram")->save();
' >/dev/null 2>&1
echo "cleanup: media type instagram label restored to 'Instagram'"

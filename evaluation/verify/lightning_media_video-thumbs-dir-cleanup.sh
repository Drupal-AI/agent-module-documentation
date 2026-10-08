#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped thumbnails directory.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("remote_video");
  $c = $t->getSource()->getConfiguration();
  $c["thumbnails_directory"] = "public://oembed_thumbnails/[date:custom:Y-m]";
  $t->set("source_configuration", $c)->save();
' >/dev/null 2>&1
echo "cleanup: remote_video thumbnails_directory restored"

#!/usr/bin/env bash
# Introspection SETUP: point the Remote video media type's oEmbed thumbnail directory at a
# distinctive path so the agent must read the live media type configuration. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("remote_video");
  $c = $t->getSource()->getConfiguration();
  $c["thumbnails_directory"] = "public://lm_video_thumbs";
  $t->set("source_configuration", $c)->save();
' >/dev/null 2>&1
echo "setup: remote_video thumbnails_directory='public://lm_video_thumbs'"

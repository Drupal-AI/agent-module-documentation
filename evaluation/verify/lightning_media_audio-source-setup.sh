#!/usr/bin/env bash
# Introspection SETUP: relabel the Audio media type so the agent has to find it by label on
# the live site and report its machine name, source plugin and source field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("audio");
  $t->set("label", "LM Podcast Audio")->save();
' >/dev/null 2>&1
echo "setup: media type audio relabelled 'LM Podcast Audio'"

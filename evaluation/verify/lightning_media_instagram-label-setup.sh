#!/usr/bin/env bash
# Introspection SETUP: relabel the Instagram media type so the agent must find it by label on
# the live site and report its machine name, source plugin id and source field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("instagram");
  $t->set("label", "LM IG Post")->save();
' >/dev/null 2>&1
echo "setup: media type instagram relabelled 'LM IG Post'"

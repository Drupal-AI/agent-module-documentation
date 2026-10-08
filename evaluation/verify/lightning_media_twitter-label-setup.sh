#!/usr/bin/env bash
# Introspection SETUP: relabel the Tweet media type so the agent must find it by label on the
# live site and report its machine name, source plugin id and source field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("tweet");
  $t->set("label", "LM Tweet Embed")->save();
' >/dev/null 2>&1
echo "setup: media type tweet relabelled 'LM Tweet Embed'"

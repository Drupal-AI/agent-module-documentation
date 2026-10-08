#!/usr/bin/env bash
# Introspection SETUP: restrict the remote_audio media type to only the iHeartRadio provider.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("remote_audio");
  $sc = $t->get("source_configuration");
  $sc["providers"] = ["iHeartRadio"];
  $t->set("source_configuration", $sc)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media.type.remote_audio providers=[iHeartRadio]"

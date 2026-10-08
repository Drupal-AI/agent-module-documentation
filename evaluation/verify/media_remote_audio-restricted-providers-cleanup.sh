#!/usr/bin/env bash
# Introspection CLEANUP: restore remote_audio providers to the shipped default (all allowed).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("remote_audio");
  $sc = $t->get("source_configuration");
  $sc["providers"] = [];
  $t->set("source_configuration", $sc)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media.type.remote_audio providers reset to {}"

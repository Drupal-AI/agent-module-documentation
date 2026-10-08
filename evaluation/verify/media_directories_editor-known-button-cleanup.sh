#!/usr/bin/env bash
# Introspection CLEANUP: restore the embed button's bundle list to what hook_install() sets
# on a fresh install (image and remote_video, when those media types exist).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $config = \Drupal::configFactory()->getEditable("embed.button.media_directories");
  if ($config->isNew()) { return; }
  $types = \Drupal::entityTypeManager()->getStorage("media_type");
  $bundles = [];
  foreach (["image", "remote_video"] as $id) { if ($types->load($id)) { $bundles[] = $id; } }
  $config->set("type_settings.bundles", $bundles)->save();
' >/dev/null 2>&1

echo "cleanup: embed.button.media_directories bundles restored to install defaults"

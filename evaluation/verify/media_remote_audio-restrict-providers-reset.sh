#!/usr/bin/env bash
# Execution RESET/CLEANUP: set remote_audio providers back to {} (all allowed) so verify
# fails on this baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("remote_audio");
  $sc = $t->get("source_configuration");
  $sc["providers"] = [];
  $t->set("source_configuration", $sc)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media.type.remote_audio providers={}"

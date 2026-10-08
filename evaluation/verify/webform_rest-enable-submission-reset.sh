#!/usr/bin/env bash
# HARD execution reset: ensure the webform_rest_submission REST resource is NOT enabled, so the
# "enable the submission read/patch resource" build task starts from a missing (failing) state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("rest_resource_config")->load("webform_rest_submission");
  if ($e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest_resource_config webform_rest_submission removed (if it existed)"

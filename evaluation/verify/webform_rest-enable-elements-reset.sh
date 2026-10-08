#!/usr/bin/env bash
# HARD execution reset: ensure the webform_rest_elements REST resource is NOT enabled, so the
# "enable the elements resource" build task starts from a missing (failing) state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("rest_resource_config")->load("webform_rest_elements");
  if ($e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest_resource_config webform_rest_elements removed (if it existed)"

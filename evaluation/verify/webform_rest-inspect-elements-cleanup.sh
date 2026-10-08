#!/usr/bin/env bash
# MEDIUM introspection cleanup: remove the webform_rest_elements resource config, restoring
# the install baseline (no webform_rest resources enabled).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("rest_resource_config")->load("webform_rest_elements");
  if ($e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest_resource_config webform_rest_elements removed"

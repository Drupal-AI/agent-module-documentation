#!/usr/bin/env bash
# MEDIUM introspection setup: enable the webform_rest_submit REST resource with a known shape
# (POST; json; cookie auth) so the agent can be asked which endpoint/method/auth it exposes.
# Restored by webform_rest-inspect-submit-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  $s = \Drupal::entityTypeManager()->getStorage("rest_resource_config");
  if ($e = $s->load("webform_rest_submit")) { $e->delete(); }
  RestResourceConfig::create([
    "id" => "webform_rest_submit",
    "plugin_id" => "webform_rest_submit",
    "granularity" => "resource",
    "configuration" => [
      "methods" => ["POST"],
      "formats" => ["json"],
      "authentication" => ["cookie"],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest_resource_config webform_rest_submit enabled (POST; json; cookie)"

#!/usr/bin/env bash
# MEDIUM introspection setup: enable the webform_rest_elements REST resource with a known
# shape (GET; json + xml; cookie auth) so the agent can be asked to read it back from live
# config. Restored by webform_rest-inspect-elements-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  $s = \Drupal::entityTypeManager()->getStorage("rest_resource_config");
  if ($e = $s->load("webform_rest_elements")) { $e->delete(); }
  RestResourceConfig::create([
    "id" => "webform_rest_elements",
    "plugin_id" => "webform_rest_elements",
    "granularity" => "resource",
    "configuration" => [
      "methods" => ["GET"],
      "formats" => ["json", "xml"],
      "authentication" => ["cookie"],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest_resource_config webform_rest_elements enabled (GET; json,xml; cookie)"

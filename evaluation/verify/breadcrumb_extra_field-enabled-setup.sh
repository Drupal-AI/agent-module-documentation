#!/usr/bin/env bash
# Introspection SETUP: enable the breadcrumb extra field for node/article in config so an agent
# can read back which entity type/bundle has it enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("breadcrumb_extra_field.settings")
    ->set("breadcrumb_extra_field_admin", ["node"=>["article"=>"article"]])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: breadcrumb enabled for node/article"

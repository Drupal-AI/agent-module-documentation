#!/usr/bin/env bash
# Stage a known Entity-warmer config on the live site so the medium introspection case has
# a real value to read back: warmer.settings:warmers.entity = frequency 900, batchSize 25,
# entity_types [node:article], published_only true.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("warmer.settings")
    ->set("warmers.entity", [
      "id" => "entity",
      "frequency" => 900,
      "batchSize" => 25,
      "entity_types" => ["node:article" => "node:article"],
      "published_only" => TRUE,
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: warmer.settings warmers.entity = frequency 900, batchSize 25"

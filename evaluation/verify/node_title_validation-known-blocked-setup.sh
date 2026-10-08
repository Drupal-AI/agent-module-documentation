#!/usr/bin/env bash
# Introspection SETUP: configure Article titles to block a distinctive word so an inspecting
# agent can read the blocklist back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_title_validation.settings")
    ->set("node_title_validation_config", [
      "unique" => FALSE,
      "content_types" => ["article" => [
        "exclude" => "ntvbanned", "comma" => FALSE, "min" => NULL, "max" => NULL,
        "min-wc" => NULL, "max-wc" => NULL, "unique" => FALSE,
      ]],
    ])->save();
' >/dev/null 2>&1
echo "setup: Article title blocklist contains 'ntvbanned'"

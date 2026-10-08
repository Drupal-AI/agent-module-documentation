#!/usr/bin/env bash
# Introspection SETUP: configure Article titles with a known minimum length (12 chars) so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_title_validation.settings")
    ->set("node_title_validation_config", [
      "unique" => FALSE,
      "content_types" => ["article" => [
        "exclude" => "", "comma" => FALSE, "min" => 12, "max" => NULL,
        "min-wc" => NULL, "max-wc" => NULL, "unique" => FALSE,
      ]],
    ])->save();
' >/dev/null 2>&1
echo "setup: Article title min length = 12"

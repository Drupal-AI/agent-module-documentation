#!/usr/bin/env bash
# Introspection SETUP: create a Key entity that uses the pantheon_secrets key provider so an
# inspecting agent can read back which Pantheon secret it points at. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("key");
  $k = $s->load("ps_known_key") ?: $s->create(["id" => "ps_known_key"]);
  $k->set("label", "PS known key")
    ->set("key_type", "authentication")
    ->set("key_provider", "pantheon")
    ->set("key_provider_settings", ["secret_name" => "ps_known_secret"])
    ->set("key_input", "none")
    ->save();
' >/dev/null 2>&1
echo "setup: key.key.ps_known_key uses key_provider pantheon, secret_name=ps_known_secret"

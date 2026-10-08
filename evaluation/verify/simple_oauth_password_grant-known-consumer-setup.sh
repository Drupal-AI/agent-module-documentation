#!/usr/bin/env bash
# Introspection SETUP: create a Simple OAuth Consumer with a known client_id and the OAuth2
# password grant enabled, so an inspecting agent can read back the client_id / enabled grants.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\consumers\Entity\Consumer;
  $existing = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id" => "sopg_probe_client"]);
  if (!$existing) {
    Consumer::create([
      "label" => "SOPG Probe Consumer",
      "client_id" => "sopg_probe_client",
      "secret" => "sopg_probe_secret",
      "grant_types" => ["password", "refresh_token"],
      "user_id" => 1,
      "is_default" => FALSE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: consumer client_id=sopg_probe_client grant_types include password"

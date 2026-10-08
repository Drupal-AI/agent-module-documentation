#!/usr/bin/env bash
# Introspection SETUP: write a single KNOWN profile into add_to_head.settings so an
# inspecting agent can read it back from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("add_to_head.settings")
    ->set("add_to_head_profiles", [
      "ath-known" => [
        "name" => "ath-known",
        "code" => "<meta name=\"ath-known\" content=\"1\">",
        "scope" => "head",
        "paths" => ["visibility" => "exclude", "paths" => ""],
        "roles" => ["visibility" => "exclude", "list" => []],
      ],
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: add_to_head.settings has profile ath-known (scope=head, code marker ath-known)"

#!/usr/bin/env bash
# Introspection SETUP: write two profiles into add_to_head.settings, one scope=head and one
# scope=scripts, so an inspecting agent must read the live config to say which one injects
# into <head>. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("add_to_head.settings")
    ->set("add_to_head_profiles", [
      "ath-head-scope" => [
        "name" => "ath-head-scope",
        "code" => "<meta name=\"ath-head-scope\" content=\"1\">",
        "scope" => "head",
        "paths" => ["visibility" => "exclude", "paths" => ""],
        "roles" => ["visibility" => "exclude", "list" => []],
      ],
      "ath-scripts-scope" => [
        "name" => "ath-scripts-scope",
        "code" => "<script>/* ath-scripts-scope */</script>",
        "scope" => "scripts",
        "paths" => ["visibility" => "exclude", "paths" => ""],
        "roles" => ["visibility" => "exclude", "list" => []],
      ],
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: add_to_head.settings has ath-head-scope (scope=head) and ath-scripts-scope (scope=scripts)"

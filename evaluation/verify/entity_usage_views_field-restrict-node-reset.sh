#!/usr/bin/env bash
# Execution RESET: set Entity Usage to track ALL target types (empty list) so the "Entity usage
# count" field is exposed on every entity type; verify (which requires EXACTLY [node]) FAILS.
# Running reset again after the task also serves as cleanup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_usage.settings")
    ->set("track_enabled_target_entity_types", [])->save();
' >/dev/null 2>&1
echo "reset: track_enabled_target_entity_types = [] (all types exposed)"

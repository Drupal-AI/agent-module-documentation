#!/usr/bin/env bash
# Execution RESET: set Entity Usage to track ALL target types (empty list); verify (which
# requires EXACTLY node+media) FAILS. Reset again after the task = cleanup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_usage.settings")
    ->set("track_enabled_target_entity_types", [])->save();
' >/dev/null 2>&1
echo "reset: track_enabled_target_entity_types = [] (all types exposed)"

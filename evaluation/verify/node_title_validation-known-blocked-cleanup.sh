#!/usr/bin/env bash
# Execution/CLEANUP RESET for node_title_validation: restore baseline by clearing all
# per-content-type rules (content_types: {}, unique: false). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_title_validation.settings")
    ->set("node_title_validation_config", ["unique" => FALSE, "content_types" => []])
    ->save();
' >/dev/null 2>&1
echo "reset: node_title_validation rules cleared (baseline)"

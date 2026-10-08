#!/usr/bin/env bash
# Execution CLEANUP: restore node exclusions to shipped default (empty). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("form_mode_manager.settings")
    ->set("form_modes.node.to_exclude", [])
    ->save();
' >/dev/null 2>&1
echo "cleanup: node.to_exclude cleared (default)"

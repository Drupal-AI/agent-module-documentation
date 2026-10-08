#!/usr/bin/env bash
# Introspection SETUP: exclude node form mode 'fmm_hidden' via form_mode_manager.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("form_mode_manager.settings")
    ->set("form_modes.node.to_exclude", ["fmm_hidden" => "fmm_hidden"])
    ->save();
' >/dev/null 2>&1
echo "setup: form_mode_manager.settings excludes node form mode fmm_hidden"

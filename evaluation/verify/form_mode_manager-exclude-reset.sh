#!/usr/bin/env bash
# Execution RESET: clear node form-mode exclusions (empty) so verify (fmm_exclude excluded) FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("form_mode_manager.settings")
    ->set("form_modes.node.to_exclude", [])
    ->save();
' >/dev/null 2>&1
echo "reset: node.to_exclude = {} (no exclusions)"

#!/usr/bin/env bash
# Execution RESET for the replicate_ui "enable taxonomy + edit access" hard case.
# Clears replicate_ui.settings to install defaults (no types, check_edit_access off) and
# rebuilds, so verify FAILs until the agent enables Replicate UI for taxonomy_term AND
# turns on check_edit_access, then rebuilds routes.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("replicate_ui.settings")
    ->set("entity_types", [])
    ->set("check_edit_access", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: replicate_ui.settings cleared (taxonomy_term not enabled, check_edit_access=false)"

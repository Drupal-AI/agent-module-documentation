#!/usr/bin/env bash
# Execution RESET for the replicate_ui "enable node" hard case.
# Clears replicate_ui.settings back to install defaults so the entity.node.replicate
# route does NOT exist, then rebuilds. After this the verify script must FAIL until the
# agent enables Replicate UI for the node entity type and rebuilds routes.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("replicate_ui.settings")
    ->set("entity_types", [])
    ->set("check_edit_access", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: replicate_ui.settings cleared (no entity types enabled); node replicate route removed"

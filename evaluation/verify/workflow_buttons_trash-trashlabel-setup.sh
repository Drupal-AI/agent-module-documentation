#!/usr/bin/env bash
# Introspection SETUP: rename the Trash state's label to a known marker.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->set("type_settings.states.trash.label","Recycle Bin Eval")->save();' >/dev/null 2>&1
echo "setup: trash state label = Recycle Bin Eval"

#!/usr/bin/env bash
# Introspection SETUP: rename the delete (to-trash) transition label to a known marker.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->set("type_settings.transitions.delete.label","Move to Bin Eval")->save();' >/dev/null 2>&1
echo "setup: delete transition label = Move to Bin Eval"

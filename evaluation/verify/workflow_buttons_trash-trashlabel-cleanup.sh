#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->set("type_settings.states.trash.label","Trash")->save();' >/dev/null 2>&1
echo "cleanup: trash state label = Trash"

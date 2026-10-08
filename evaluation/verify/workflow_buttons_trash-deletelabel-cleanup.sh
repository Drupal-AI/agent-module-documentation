#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->set("type_settings.transitions.delete.label","Delete")->save();' >/dev/null 2>&1
echo "cleanup: delete transition label = Delete"

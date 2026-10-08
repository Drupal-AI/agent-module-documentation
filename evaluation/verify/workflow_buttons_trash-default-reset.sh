#!/usr/bin/env bash
# Execution RESET: set the Trash workflow default state to 'published' (wrong) so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->set("type_settings.default_moderation_state","published")->save();' >/dev/null 2>&1
echo "reset: default_moderation_state=published"

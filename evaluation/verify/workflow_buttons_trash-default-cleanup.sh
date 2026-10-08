#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->set("type_settings.default_moderation_state","draft")->save();' >/dev/null 2>&1
echo "cleanup: default_moderation_state=draft (default)"

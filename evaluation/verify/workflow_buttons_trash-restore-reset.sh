#!/usr/bin/env bash
# Execution RESET: delete the Trash workflow so verify FAILS until restored.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $w=\Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing");
  if (!$w->isNew()) { $w->delete(); }
' >/dev/null 2>&1
echo "reset: workflow_buttons_trash_publishing deleted"

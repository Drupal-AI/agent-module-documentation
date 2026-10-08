#!/usr/bin/env bash
# Execution RESET: prevent_complete_own FALSE (shipped default) so verify fails first.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("registration_workflow.settings")->set("prevent_complete_own", FALSE)->save();' >/dev/null 2>&1
echo "reset: registration_workflow.settings prevent_complete_own=FALSE"

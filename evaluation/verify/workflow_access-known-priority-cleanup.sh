#!/usr/bin/env bash
# Introspection CLEANUP: restore Workflow Access priority to the shipped default (0).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflow_access.settings")->set("workflow_access_priority", 0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: workflow_access_priority restored to 0"

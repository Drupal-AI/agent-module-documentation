#!/usr/bin/env bash
# Introspection SETUP: set the Workflow Access node-grant priority to a known value (7). An
# inspecting agent should read workflow_access.settings and report the priority. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflow_access.settings")->set("workflow_access_priority", 7)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: workflow_access.settings workflow_access_priority=7"

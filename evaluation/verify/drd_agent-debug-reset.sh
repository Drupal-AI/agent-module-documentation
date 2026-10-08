#!/usr/bin/env bash
# Execution RESET: force Debug mode OFF (State drd_agent.debug_mode=FALSE) so verify FAILS until
# the agent enables it via the DRD Agent settings.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("drd_agent.debug_mode", FALSE);' >/dev/null 2>&1
echo "reset: drd_agent.debug_mode=FALSE"

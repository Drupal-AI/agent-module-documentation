#!/usr/bin/env bash
# Execution RESET: delete the role the agent must create for the Pantheon sync page.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("ps_secrets_manager")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role ps_secrets_manager absent"

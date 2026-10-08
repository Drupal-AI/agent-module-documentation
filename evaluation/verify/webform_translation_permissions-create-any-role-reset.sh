#!/usr/bin/env bash
# Execution RESET: ensure role wtp_translator does NOT exist, so verify FAILS until the agent
# creates it with 'translate any webform' (and without 'translate configuration'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("wtp_translator")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role wtp_translator absent"

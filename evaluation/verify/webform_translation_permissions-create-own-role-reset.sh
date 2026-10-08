#!/usr/bin/env bash
# Execution RESET: ensure role wtp_owner does NOT exist, so verify FAILS until the agent creates
# it with 'translate own webform' (and without 'translate any webform'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("wtp_owner")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role wtp_owner absent"

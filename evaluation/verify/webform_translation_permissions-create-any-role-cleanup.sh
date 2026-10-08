#!/usr/bin/env bash
# Execution CLEANUP: remove the wtp_translator role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("wtp_translator")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role wtp_translator removed"

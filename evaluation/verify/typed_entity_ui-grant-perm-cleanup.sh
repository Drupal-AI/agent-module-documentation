#!/usr/bin/env bash
# Execution CLEANUP: delete role te_ui_role and uninstall typed_entity_ui. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("te_ui_role")) { $r->delete(); }
' >/dev/null 2>&1
drush pmu typed_entity_ui -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: te_ui_role deleted; typed_entity_ui uninstalled"

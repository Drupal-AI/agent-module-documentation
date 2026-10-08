#!/usr/bin/env bash
# Execution CLEANUP: delete the tm_editor role and the tm_gate vocabulary created by the
# reset. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if ($r = Role::load("tm_editor")) { $r->delete(); }
  if ($v = Vocabulary::load("tm_gate")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role tm_editor and vocabulary tm_gate removed"

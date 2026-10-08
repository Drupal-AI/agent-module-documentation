#!/usr/bin/env bash
# Introspection CLEANUP: delete the pfdp_intro_* directory entities and the pfdp_intro_role
# role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\pfdp\Entity\DirectoryEntity;
  use Drupal\user\Entity\Role;
  foreach (["pfdp_intro_open", "pfdp_intro_locked"] as $id) {
    if ($d = DirectoryEntity::load($id)) { $d->delete(); }
  }
  if ($r = Role::load("pfdp_intro_role")) { $r->delete(); }
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pfdp_intro_* directories and role removed"

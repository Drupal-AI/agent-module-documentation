#!/usr/bin/env bash
# Introspection CLEANUP: delete the pfdp_intro_user directory, the two fixture accounts, and
# the pfdp.settings object (which does not exist on a stock install of this module).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\pfdp\Entity\DirectoryEntity;
  if ($d = DirectoryEntity::load("pfdp_intro_user")) { $d->delete(); }
  foreach (["pfdp_intro_reader", "pfdp_intro_other"] as $name) {
    if ($u = user_load_by_name($name)) { $u->delete(); }
  }
  \Drupal::configFactory()->getEditable("pfdp.settings")->delete();
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pfdp_intro_user directory, fixture accounts and pfdp.settings removed"

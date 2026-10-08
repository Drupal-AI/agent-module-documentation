#!/usr/bin/env bash
# Introspection CLEANUP: delete the two fixture roles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["ful_intro_ops", "ful_intro_view"] as $rid) {
    if ($r = Role::load($rid)) { $r->delete(); }
  }
  print "cleaned\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: ful_intro_ops / ful_intro_view removed"

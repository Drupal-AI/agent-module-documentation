#!/usr/bin/env bash
# Introspection CLEANUP: delete the two namespaced roles and the tm_known vocabulary created
# by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  foreach (["tm_merger", "tm_bystander"] as $rid) {
    if ($r = Role::load($rid)) { $r->delete(); }
  }
  if ($v = Vocabulary::load("tm_known")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles tm_merger, tm_bystander and vocabulary tm_known removed"

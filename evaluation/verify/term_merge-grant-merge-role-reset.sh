#!/usr/bin/env bash
# Execution RESET: create the vocabulary tm_gate and a role tm_editor that has NEITHER of the
# two permissions term_merge's routes require, so verify FAILS until the agent grants them.
# Any previously granted merge permissions are explicitly revoked. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if (!Vocabulary::load("tm_gate")) {
    Vocabulary::create(["vid" => "tm_gate", "name" => "TM Gate"])->save();
  }
  $r = Role::load("tm_editor") ?: Role::create(["id" => "tm_editor", "label" => "TM Editor"]);
  foreach (["merge taxonomy terms", "edit terms in tm_gate", "administer taxonomy"] as $p) {
    $r->revokePermission($p);
  }
  $r->save();
  $check = Role::load("tm_editor");
  print "reset: role tm_editor perms=[" . implode("|", $check->getPermissions()) . "]\n";
' 2>/dev/null
drush cr >/dev/null 2>&1

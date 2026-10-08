#!/usr/bin/env bash
# Execution RESET: create the vocabulary tm_access, a role tm_access_role stripped of every
# permission relevant to term_merge, and the user tm_access_user holding only that role. The
# user therefore cannot reach entity.taxonomy_vocabulary.merge_form, so verify FAILS until the
# agent opens that access up. Idempotent (recreates the user's role set each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;
  if (!Vocabulary::load("tm_access")) {
    Vocabulary::create(["vid" => "tm_access", "name" => "TM Access"])->save();
  }
  $r = Role::load("tm_access_role") ?: Role::create(["id" => "tm_access_role", "label" => "TM Access Role"]);
  foreach (["merge taxonomy terms", "edit terms in tm_access", "administer taxonomy"] as $p) {
    $r->revokePermission($p);
  }
  $r->save();
  $users = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "tm_access_user"]);
  $u = $users ? reset($users) : User::create(["name" => "tm_access_user", "status" => 1]);
  foreach ($u->getRoles(TRUE) as $rid) { $u->removeRole($rid); }
  $u->addRole("tm_access_role");
  $u->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $users = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "tm_access_user"]);
  $u = $users ? reset($users) : NULL;
  $can = FALSE;
  if ($u) {
    $can = \Drupal::service("access_manager")->checkNamedRoute(
      "entity.taxonomy_vocabulary.merge_form",
      ["taxonomy_vocabulary" => "tm_access"],
      $u
    );
  }
  print "reset: user tm_access_user uid=" . ($u ? $u->id() : "MISSING")
    . " roles=[" . implode("|", $u ? $u->getRoles() : []) . "]"
    . " can_reach_merge_form=" . var_export((bool) $can, TRUE) . "\n";
' 2>/dev/null

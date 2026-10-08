#!/usr/bin/env bash
# Introspection SETUP: create the vocabulary tm_known and TWO namespaced roles —
# tm_merger, which really can use the Term Merge wizard (both required permissions), and
# tm_bystander, which only has 'edit terms in tm_known' and therefore cannot. The agent must
# inspect the live user.role.* config to work out which role passes term_merge's two-layer
# access gate. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if (!Vocabulary::load("tm_known")) {
    Vocabulary::create(["vid" => "tm_known", "name" => "TM Known"])->save();
  }
  $merger = Role::load("tm_merger") ?: Role::create(["id" => "tm_merger", "label" => "TM Merger"]);
  $merger->grantPermission("merge taxonomy terms");
  $merger->grantPermission("edit terms in tm_known");
  $merger->save();
  $bystander = Role::load("tm_bystander") ?: Role::create(["id" => "tm_bystander", "label" => "TM Bystander"]);
  $bystander->revokePermission("merge taxonomy terms");
  $bystander->grantPermission("edit terms in tm_known");
  $bystander->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary tm_known; role tm_merger has 'merge taxonomy terms' + 'edit terms in tm_known'; role tm_bystander has only 'edit terms in tm_known'"

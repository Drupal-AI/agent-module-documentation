#!/usr/bin/env bash
# Introspection SETUP: create a user with a distinctive account name; store uid in State
# bamboo_loader_uid2 so the agent can load it and read the username back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $u = user_load_by_name("bts_loader_marker_qx99");
  if (!$u) { $u = User::create(["name"=>"bts_loader_marker_qx99","mail"=>"bts_loader_marker_qx99@example.com","status"=>1]); $u->save(); }
  \Drupal::state()->set("bamboo_loader_uid2", (int) $u->id());
' >/dev/null 2>&1
echo "setup: user bts_loader_marker_qx99, uid in state bamboo_loader_uid2"

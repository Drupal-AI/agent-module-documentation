#!/usr/bin/env bash
# Introspection SETUP: create user bts_loader_user with a distinctive email; store its uid in State
# bamboo_loader_uid so the agent can load it and read the email back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $u = user_load_by_name("bts_loader_user");
  if (!$u) { $u = User::create(["name"=>"bts_loader_user","mail"=>"loader-ocelot-4242@example.com","status"=>1]); $u->save(); }
  \Drupal::state()->set("bamboo_loader_uid", (int) $u->id());
' >/dev/null 2>&1
echo "setup: user bts_loader_user (mail loader-ocelot-4242@example.com), uid in state bamboo_loader_uid"

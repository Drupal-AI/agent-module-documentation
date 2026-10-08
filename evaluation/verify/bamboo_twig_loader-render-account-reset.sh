#!/usr/bin/env bash
# Execution RESET: create a user with a known account name, store uid in State
# bamboo_loader_render_uid, and remove the agent template so verify FAILS until built.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $u = user_load_by_name("bamboo_render_user_71");
  if (!$u) { $u = User::create(["name"=>"bamboo_render_user_71","mail"=>"bamboo_render_user_71@example.com","status"=>1]); $u->save(); }
  \Drupal::state()->set("bamboo_loader_render_uid", (int) $u->id());
' >/dev/null 2>&1
rm -f web/sites/default/files/bamboo_twig_loader_render_account.html.twig
echo "reset: user bamboo_render_user_71 (uid in state bamboo_loader_render_uid), template removed"

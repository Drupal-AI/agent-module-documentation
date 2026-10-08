#!/usr/bin/env bash
# Introspection SETUP: create two custom roles — ful_intro_ops WITH the core permission
# 'administer users' (which is what every Force Users Logout route requires) and ful_intro_view
# WITHOUT it — so the agent must inspect live role config to say who can reach the forms.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("ful_intro_ops")) { Role::create(["id" => "ful_intro_ops", "label" => "FUL Intro Ops"])->save(); }
  if (!Role::load("ful_intro_view")) { Role::create(["id" => "ful_intro_view", "label" => "FUL Intro Viewer"])->save(); }
  $ops = Role::load("ful_intro_ops");
  $ops->grantPermission("administer users")->save();
  $view = Role::load("ful_intro_view");
  $view->revokePermission("administer users");
  $view->grantPermission("access content")->save();
  print "ops=" . json_encode($ops->getPermissions()) . " view=" . json_encode($view->getPermissions()) . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: ful_intro_ops has 'administer users', ful_intro_view does not"

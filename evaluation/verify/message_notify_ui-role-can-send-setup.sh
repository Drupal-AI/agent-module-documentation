#!/usr/bin/env bash
# Introspection SETUP: create role 'mnui_sender' granted 'send message through the ui'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mnui_sender") ?: Role::create(["id"=>"mnui_sender","label"=>"MNUI Sender"]);
  $r->grantPermission("send message through the ui"); $r->save();
' >/dev/null 2>&1
echo "setup: role mnui_sender granted 'send message through the ui'"

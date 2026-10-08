#!/usr/bin/env bash
# Introspection SETUP: create a known group_content_menu_type (id gcm_secondary, label
# 'GCM Secondary Nav') so an agent can map label -> id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group_content_menu\Entity\GroupContentMenuType;
  if ($t = GroupContentMenuType::load("gcm_secondary")) { $t->delete(); }
  GroupContentMenuType::create(["id"=>"gcm_secondary","label"=>"GCM Secondary Nav"])->save();
' >/dev/null 2>&1
echo "setup: group_content_menu_type gcm_secondary (label 'GCM Secondary Nav')"

#!/usr/bin/env bash
# Execution RESET: (re)create group_content_menu_type gcm_relabel with label 'Old Label' so
# verify FAILS until the agent relabels it to 'New Label'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group_content_menu\Entity\GroupContentMenuType;
  if ($t = GroupContentMenuType::load("gcm_relabel")) { $t->delete(); }
  GroupContentMenuType::create(["id"=>"gcm_relabel","label"=>"Old Label"])->save();
' >/dev/null 2>&1
echo "reset: group_content_menu_type gcm_relabel label='Old Label'"

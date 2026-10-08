#!/usr/bin/env bash
# Introspection SETUP: create a known group_content_menu_type (id gcm_probe, label
# 'GCM Probe Menu Type') so an agent can read its label back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group_content_menu\Entity\GroupContentMenuType;
  if ($t = GroupContentMenuType::load("gcm_probe")) { $t->delete(); }
  GroupContentMenuType::create(["id"=>"gcm_probe","label"=>"GCM Probe Menu Type"])->save();
' >/dev/null 2>&1
echo "setup: group_content_menu_type gcm_probe (label 'GCM Probe Menu Type')"

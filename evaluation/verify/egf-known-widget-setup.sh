#!/usr/bin/env bash
# Introspection SETUP: place the entitygroupfield Group select widget on the user form. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  $fd->setComponent("entitygroupfield",["type"=>"entitygroupfield_select_widget","region"=>"content","weight"=>5,"settings"=>["label"=>"Groups","help_text"=>"","multiple"=>true,"required"=>false]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user form entitygroupfield = entitygroupfield_select_widget"

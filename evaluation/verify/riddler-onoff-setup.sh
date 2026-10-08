#!/usr/bin/env bash
# Introspection SETUP: two riddles, ri_active enabled and ri_paused disabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("riddle");
  if (!$s->load("ri_active")) { $s->create(["id"=>"ri_active","question"=>"Enabled riddle?","solution"=>"yes","hint"=>"","status"=>TRUE])->save(); }
  if (!$s->load("ri_paused")) { $s->create(["id"=>"ri_paused","question"=>"Disabled riddle?","solution"=>"no","hint"=>"","status"=>FALSE])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ri_active(enabled) + ri_paused(disabled)"

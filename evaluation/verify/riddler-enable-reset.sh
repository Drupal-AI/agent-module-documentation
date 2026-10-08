#!/usr/bin/env bash
# Execution RESET: create riddle ri_toggle in DISABLED state (so verify FAILS until agent enables it).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("riddle");
  if ($e = $s->load("ri_toggle")) { $e->delete(); }
  $s->create(["id"=>"ri_toggle","question"=>"Is this riddle enabled?","solution"=>"yes","hint"=>"","status"=>FALSE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: riddle ri_toggle present but DISABLED"

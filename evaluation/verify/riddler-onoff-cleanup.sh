#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("riddle");
  foreach (["ri_active","ri_paused"] as $id) { if ($e=$s->load($id)) { $e->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ri_active/ri_paused removed"

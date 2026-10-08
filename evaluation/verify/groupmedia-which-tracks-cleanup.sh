#!/usr/bin/env bash
# Introspection CLEANUP for gm_med2.
# Removes EVERY group.relationship_type.gm_med2-* (incl. the auto-installed group_membership) then
# the group type, via raw config delete. Leaving an orphaned relationship_type whose group type
# is gone breaks site-wide bundle info, so all relations must go. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  foreach ($cf->listAll("group.relationship_type.gm_med2-") as $n) { $cf->getEditable($n)->delete(); }
  $cf->getEditable("group.type.gm_med2")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gm_med2 group type and all its group relationship types removed"

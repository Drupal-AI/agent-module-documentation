#!/usr/bin/env bash
# Shared CLEANUP for the execution cases: delete every eval-created view so the site is
# left at baseline. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["vcfo_eval_build", "vcfo_eval_toggle", "vcfo_eval_known"] as $id) {
    if ($v = \Drupal\views\Entity\View::load($id)) { $v->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval views removed (vcfo_eval_build, vcfo_eval_toggle, vcfo_eval_known)"

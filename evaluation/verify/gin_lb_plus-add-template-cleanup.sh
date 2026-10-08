#!/usr/bin/env bash
# Execution CLEANUP (gin_lb_plus): delete section_library_template(s) labeled 'glb_plus_exec'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("section_library_template");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label", "glb_plus_exec")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: glb_plus_exec removed"

#!/usr/bin/env bash
# Execution RESET (gin_lb_plus): ensure NO section_library_template labeled 'glb_plus_exec'
# exists, so verify FAILS until the agent creates one. Only touches that namespaced label.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("section_library_template");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label", "glb_plus_exec")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no section_library_template glb_plus_exec"

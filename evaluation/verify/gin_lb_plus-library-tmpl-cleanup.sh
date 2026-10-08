#!/usr/bin/env bash
# Introspection CLEANUP (gin_lb_plus): delete the section_library_template(s) labeled
# 'glb_plus_known_tmpl' created by the matching setup. Only touches that namespaced label.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("section_library_template");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label", "glb_plus_known_tmpl")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: glb_plus_known_tmpl removed"

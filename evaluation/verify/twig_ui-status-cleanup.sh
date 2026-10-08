#!/usr/bin/env bash
# Introspection CLEANUP: delete twui_on and twui_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("twig_template");
  foreach (["twui_on","twui_off"] as $id) { if ($t = $s->load($id)) { $t->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twui_on and twui_off removed"

#!/usr/bin/env bash
# Introspection CLEANUP: delete the twui_known template (removes its files too). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("twig_template");
  if ($t = $s->load("twui_known")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_template twui_known removed"

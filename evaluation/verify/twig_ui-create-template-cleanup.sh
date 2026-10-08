#!/usr/bin/env bash
# Execution CLEANUP: delete the twui_task template (and its files). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("twig_template");
  if ($t = $s->load("twui_task")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_template twui_task removed"

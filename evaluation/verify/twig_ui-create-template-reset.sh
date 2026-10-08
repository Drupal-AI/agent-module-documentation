#!/usr/bin/env bash
# Execution RESET: ensure the twui_task Twig UI template does NOT exist, so verify fails on
# empty state until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("twig_template");
  if ($t = $s->load("twui_task")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: twig_template twui_task absent"

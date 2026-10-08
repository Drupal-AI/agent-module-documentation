#!/usr/bin/env bash
# Execution CLEANUP: delete the input/output state keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->delete("twig_remove_html_comments_input");
  \Drupal::state()->delete("twig_remove_html_comments_output");
' >/dev/null 2>&1
echo "cleanup: input/output state keys deleted"

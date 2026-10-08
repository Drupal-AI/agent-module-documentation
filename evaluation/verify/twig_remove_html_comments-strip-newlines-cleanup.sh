#!/usr/bin/env bash
# Execution CLEANUP: delete the nl_input/nl_output state keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->delete("twig_remove_html_comments_nl_input");
  \Drupal::state()->delete("twig_remove_html_comments_nl_output");
' >/dev/null 2>&1
echo "cleanup: nl_input/nl_output state keys deleted"

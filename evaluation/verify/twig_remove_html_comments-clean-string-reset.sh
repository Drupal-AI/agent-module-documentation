#!/usr/bin/env bash
# Execution RESET: set the input state key with an HTML string that contains a comment, and
# CLEAR the output state key so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_remove_html_comments_input", "<p>Keep this</p><!-- SECRET internal note -->");
  \Drupal::state()->delete("twig_remove_html_comments_output");
' >/dev/null 2>&1
echo "reset: input set (has <!-- SECRET ... -->), output cleared"

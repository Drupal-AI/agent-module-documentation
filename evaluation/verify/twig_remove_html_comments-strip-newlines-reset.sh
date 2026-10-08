#!/usr/bin/env bash
# Execution RESET: set a multi-line input containing a comment AND newlines in state key
# twig_remove_html_comments_nl_input, and clear the output key twig_remove_html_comments_nl_output
# so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_remove_html_comments_nl_input", "Line one\n<!-- drop this -->\nLine two\n");
  \Drupal::state()->delete("twig_remove_html_comments_nl_output");
' >/dev/null 2>&1
echo "reset: nl_input set (newlines + a comment), nl_output cleared"

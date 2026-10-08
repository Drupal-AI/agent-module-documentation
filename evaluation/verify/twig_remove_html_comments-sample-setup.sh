#!/usr/bin/env bash
# Introspection SETUP: store a known HTML string (with comments + newlines) in Drupal state key
# twig_remove_html_comments_sample, so the agent can load it and run it through the module's
# filter on the live site to report the cleaned result. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_remove_html_comments_sample", "<h2>Report</h2><!-- internal: draft -->\n<p>Total sales: 42</p>");
' >/dev/null 2>&1
echo "setup: state twig_remove_html_comments_sample set (contains one HTML comment + a newline)"

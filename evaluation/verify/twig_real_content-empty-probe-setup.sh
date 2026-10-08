#!/usr/bin/env bash
# Introspection SETUP: store a known empty-wrapper markup string in Drupal state so the agent
# can read it back and evaluate it with twig_real_content. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_real_content_probe", "<div class=\"region region-sidebar\"> \n\t </div>");
' >/dev/null 2>&1
echo "setup: state twig_real_content_probe = empty sidebar wrapper"

#!/usr/bin/env bash
# Introspection SETUP: store a known image-only markup string in Drupal state (an <img> is on
# the twig_real_content allowlist, so it counts as real content). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_real_content_probe2", "<div class=\"region\"><img src=\"hero.jpg\" alt=\"\"></div>");
' >/dev/null 2>&1
echo "setup: state twig_real_content_probe2 = image-only region"

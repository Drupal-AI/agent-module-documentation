#!/usr/bin/env bash
# Execution RESET: set the known input string in state and clear the output key so verify
# FAILS until the agent computes the filter result. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_real_content_in1", "<div class=\"promo\"><p>Buy now</p><img src=\"x\"></div>");
  \Drupal::state()->delete("twig_real_content_out1");
' >/dev/null 2>&1
echo "reset: twig_real_content_in1 set, twig_real_content_out1 cleared"

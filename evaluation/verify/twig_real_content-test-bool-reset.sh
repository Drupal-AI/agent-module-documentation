#!/usr/bin/env bash
# Execution RESET: set the known input string in state and clear the output key so verify
# FAILS until the agent computes the real_content test result. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("twig_real_content_in2", "<div><svg></svg></div>");
  \Drupal::state()->delete("twig_real_content_out2");
' >/dev/null 2>&1
echo "reset: twig_real_content_in2 set, twig_real_content_out2 cleared"

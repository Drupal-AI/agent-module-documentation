#!/usr/bin/env bash
# Execution CLEANUP: remove the input/output state keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->delete("twig_real_content_in2");
  \Drupal::state()->delete("twig_real_content_out2");
' >/dev/null 2>&1
echo "cleanup: twig_real_content_in2/out2 deleted"

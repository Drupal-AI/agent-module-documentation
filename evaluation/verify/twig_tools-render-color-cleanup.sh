#!/usr/bin/env bash
# Execution CLEANUP: remove the twig_tools_eval.result config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twig_tools_eval.result")->delete();' >/dev/null 2>&1
echo "cleanup: twig_tools_eval.result removed"

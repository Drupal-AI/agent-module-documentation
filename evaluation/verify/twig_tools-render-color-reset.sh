#!/usr/bin/env bash
# Execution RESET: clear the twig_tools_eval.result config so verify FAILS until the agent uses
# twig_tools to render the CSS rgb() form of the hex color #3366cc and store it there. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twig_tools_eval.result")->delete();' >/dev/null 2>&1
echo "reset: twig_tools_eval.result cleared"

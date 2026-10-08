#!/usr/bin/env bash
# Execution RESET: force twig_ui.settings back to shipped defaults (allowed_themes=all, empty
# allowed_theme_list) so verify FAILS until the agent restricts to selected+olivero. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("twig_ui.settings");
  $c->set("allowed_themes", "all")->set("allowed_theme_list", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: twig_ui.settings allowed_themes=all, allowed_theme_list=[]"

#!/usr/bin/env bash
# Execution CLEANUP: restore twig_ui.settings shipped defaults (allowed_themes=all, empty list).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("twig_ui.settings");
  $c->set("allowed_themes", "all")->set("allowed_theme_list", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_ui.settings restored to defaults"

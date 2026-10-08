#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("flippy.settings");
  $c->clear("flippy_article")->clear("flippy_custom_sorting_article")
    ->clear("flippy_sort_article")->clear("flippy_order_article")->save();
' >/dev/null 2>&1
echo "cleanup: Article flippy sort keys cleared"

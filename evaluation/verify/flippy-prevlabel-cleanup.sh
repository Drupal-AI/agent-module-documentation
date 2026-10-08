#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("flippy.settings");
  $c->clear("flippy_article")->clear("flippy_prev_label_article")->save();
' >/dev/null 2>&1
echo "cleanup: flippy article keys cleared"

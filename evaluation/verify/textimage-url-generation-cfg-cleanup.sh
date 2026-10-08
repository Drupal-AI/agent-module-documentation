#!/usr/bin/env bash
# Introspection CLEANUP: restore url_generation to shipped defaults (disabled, separator '---').
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("textimage.settings");
  $c->set("url_generation.enabled", FALSE)->set("url_generation.text_separator", "---")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: textimage.settings url_generation reset (disabled, '---')"

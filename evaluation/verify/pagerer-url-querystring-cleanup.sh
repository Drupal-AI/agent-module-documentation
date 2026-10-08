#!/usr/bin/env bash
# Restore shipped defaults for pagerer.settings url_querystring.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pagerer.settings");
  $c->set("url_querystring.core_override", FALSE)
    ->set("url_querystring.querystring_key", "pg")
    ->set("url_querystring.index_base", 0)
    ->set("url_querystring.encode_method", "none")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pagerer.settings url_querystring restored to defaults"

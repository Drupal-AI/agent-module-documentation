#!/usr/bin/env bash
# Restore http_cache_control.settings to install defaults after the introspection case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("http_cache_control.settings");
  $c->setData([
    "cache" => [
      "http" => [
        "mustrevalidate"=>false,"nocache"=>false,"nostore"=>false,
        "s_maxage"=>0,"404_max_age"=>0,"302_max_age"=>0,"301_max_age"=>0,
        "stale_while_revalidate"=>0,"stale_if_error"=>0,"vary"=>"",
      ],
      "surrogate" => ["maxage"=>0,"nostore"=>false],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: http_cache_control.settings restored to install defaults"

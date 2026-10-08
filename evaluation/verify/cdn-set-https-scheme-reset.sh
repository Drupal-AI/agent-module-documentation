#!/usr/bin/env bash
# Execution RESET: restore cdn.settings baseline (scheme '//') so verify FAILS until changed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$c=\Drupal::configFactory()->getEditable("cdn.settings");
  $c->set("status", FALSE)
    ->set("scheme", "//")
    ->set("mapping", ["type"=>"simple","domain"=>NULL,"conditions"=>["not"=>["extensions"=>["css","js"]]]])
    ->set("farfuture", ["status"=>TRUE])
    ->set("stream_wrappers", ["public"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cdn.settings scheme = //"

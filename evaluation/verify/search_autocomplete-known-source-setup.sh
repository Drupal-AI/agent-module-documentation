#!/usr/bin/env bash
# Introspection SETUP: create a config whose suggestion source is the users callback. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
if (!$s->load("sa_users_probe")) {
  $s->create(["id"=>"sa_users_probe","label"=>"SA Users Probe","selector"=>"#edit-sa-users","status"=>TRUE,
    "minChar"=>2,"maxSuggestions"=>10,
    "source"=>"autocompletion_callbacks_users::users_autocompletion_callback",
    "theme"=>"basic.css","editable"=>TRUE,"deletable"=>TRUE])->save();
}
' >/dev/null 2>&1
echo "setup: autocompletion_configuration sa_users_probe source=autocompletion_callbacks_users::users_autocompletion_callback"

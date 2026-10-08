#!/usr/bin/env bash
# Introspection SETUP: create a known autocompletion_configuration so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
if (!$s->load("sa_probe")) {
  $s->create(["id"=>"sa_probe","label"=>"SA Probe","selector"=>"#probe-field","status"=>TRUE,
    "minChar"=>4,"maxSuggestions"=>8,
    "source"=>"autocompletion_callbacks_nodes::nodes_autocompletion_callback",
    "theme"=>"basic.css","editable"=>TRUE,"deletable"=>TRUE])->save();
}
' >/dev/null 2>&1
echo "setup: autocompletion_configuration sa_probe selector=#probe-field minChar=4"

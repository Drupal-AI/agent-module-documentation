#!/usr/bin/env bash
# Introspection SETUP: enable the example submodule and place the Example Node Label extra
# field on Article default display with a KNOWN wrapper (h2), so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush en extra_field_plus_example -y >/dev/null 2>&1
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("extra_field_example_node_label", ["type" => "extra_field_example_node_label", "weight" => 20, "region" => "content", "settings" => ["link_to_entity" => TRUE, "wrapper" => "h2"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: extra_field_example_node_label wrapper=h2 link_to_entity=true"

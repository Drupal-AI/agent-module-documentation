#!/usr/bin/env bash
# Execution RESET: enable submodule and place the FORMATTED extra field with link_to_entity
# OFF (wrapper span), so verify FAILs until the agent turns link_to_entity ON.
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
  $fd->setComponent("extra_field_example_node_label_formatted", ["type" => "extra_field_example_node_label_formatted", "weight" => 20, "region" => "content", "settings" => ["link_to_entity" => FALSE, "wrapper" => "span"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_example_node_label_formatted link_to_entity=false"
